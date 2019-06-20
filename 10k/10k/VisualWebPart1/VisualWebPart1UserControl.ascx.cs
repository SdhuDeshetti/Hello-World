using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint.Client;
using Microsoft.SharePoint;
using System.Web;
using Microsoft.SharePoint.Administration.Claims;
using System.Globalization;
using System.Data;
using System.Net.Mail;
using System.Configuration;
using System.Net;
using System.Web.UI;
using System.Text.RegularExpressions;

namespace _10k.VisualWebPart1
{
    public partial class VisualWebPart1UserControl : UserControl
    {
        DataTable dtRM = new DataTable();
        string sttName = string.Empty;
        string sttEmail = string.Empty;
        string SiteURL = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);
        string host = HttpContext.Current.Request.Url.Host;
        string ListITemID = string.Empty;
        DataTable dt10kRun = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            sttEmail = SPContext.Current.Web.CurrentUser.Email;            
            Get10KRun();
            if (!Page.IsPostBack)
            {
                GetEmployeeInfo(sttEmail);
                GetData(sttEmail);
                //if (dt10kRun.Rows.Count <= 50)
                //{
                //    lblErrorMessage.Text = "";
                //}
                //else
                //{
                //    lblErrorMessage.Text = "Already 50 nomintions completed..";                    
                //    btnsave.Visible = false;
                //}
            }            
        }

        private void GetEmployeeInfo(string stEmail)
        {
            try
            {
                SPWebCollection subsites;
                SPSite site = SPContext.Current.Site;
                subsites = site.RootWeb.Webs;
                SPWeb web = subsites["HR"];
                Guid SiteiD = web.Site.ID;
                Guid WebiD = web.ID;
                SPSecurity.RunWithElevatedPrivileges(delegate()
                {
                    using (SPSite Site = new SPSite(SiteiD))
                    {
                        using (SPWeb EvlWebHR = Site.OpenWeb(WebiD))
                        {
                            if (!string.IsNullOrEmpty(stEmail))
                            {                                
                                SPList RMList = EvlWebHR.Lists["Resource Master"];
                                SPQuery Query = new SPQuery();
                                Query.Query = "<Where><And><Eq><FieldRef Name='Email'/><Value Type='Text'>" + stEmail + "</Value></Eq><Eq><FieldRef Name='Status'/><Value Type='Text'>Active</Value></Eq></And></Where>";
                                Query.ViewFields = string.Concat("<FieldRef Name='Title'/>", "<FieldRef Name='Employee_x0020_Name'/>", "<FieldRef Name='Email'/>","<FieldRef Name='Business_x0020_Unit'/>", "<FieldRef Name='Designation'/>", "<FieldRef Name='Account'/>","<FieldRef Name='Status'/>");
                                Query.ViewFieldsOnly = true;
                                SPListItemCollection RMItems = RMList.GetItems(Query);
                                dtRM = RMItems.GetDataTable();
                                if (RMItems.Count>0)
                                {
                                    txtVAMID.Text = dtRM.Rows[0]["Title"].ToString();
                                    txtName.Text = dtRM.Rows[0]["Employee_x0020_Name"].ToString();
                                    txtdesignation.Text = dtRM.Rows[0]["Designation"].ToString();
                                    txtAccount.Text = dtRM.Rows[0]["Account"].ToString();
                                    txtDepartment.Text = dtRM.Rows[0]["Business_x0020_Unit"].ToString();
                                }
                            }
                        }
                    }
                });

            }
            catch (Exception exp) { }

        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            lblErrorMessage.Text = "";
            GetData(sttEmail);
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            //lblErrorMessage.Text = "";
            UpdateMethod();
            GetData(sttEmail);
        }
            
        private void GetData(string Email)
        {
            SPWeb web = SPContext.Current.Web;
            Guid SiteiD = web.Site.ID;
            Guid WebiD = web.ID;
            SPSecurity.RunWithElevatedPrivileges(delegate()
            {
                using (SPSite SiteMysite = new SPSite(SiteiD))
                {
                    using (SPWeb EvlWebHR = SiteMysite.OpenWeb(WebiD))
                    {
                        SPList GenInsuList = EvlWebHR.Lists["10KRunSurvey"];
                        SPQuery query = new SPQuery();
                        query.Query = "<Where><Eq><FieldRef Name='Email'/><Value Type='Text' >" + Email + "</Value></Eq></Where>";
                        query.ViewFieldsOnly = true;
                        SPListItemCollection items = GenInsuList.GetItems(query);
                         ListITemID = string.Empty;
                        if (items.Count > 0)           
                        {                            
                            foreach (SPListItem item in items)
                            {
                                txtVAMID.Text = item["Title"] != null ? item["Title"].ToString() : string.Empty;
                                txtName.Text = item["Name"] != null ? item["Name"].ToString() : string.Empty;
                                txtdesignation.Text = item["Designation"] != null ? item["Designation"].ToString() : string.Empty;
                                txtDepartment.Text = item["Department"] != null ? item["Department"].ToString() : string.Empty;
                                txtAccount.Text = item["Account"] != null ? item["Account"].ToString() : string.Empty;
                                //rbType.SelectedValue = item["RunType"].ToString();
                                rbSize.SelectedValue = item["Size"].ToString();                                    
                            }
                            btnsave.Visible = false;                            
                        }
                        else
                        {                                                        
                            rbSize.ClearSelection();
                            //rbType.ClearSelection();
                        }
                    }
                }
            });
        }

        protected void Get10KRun()
        {
            SPWeb web = SPContext.Current.Web;
            Guid SiteiD = web.Site.ID;
            Guid WebiD = web.ID;
            SPSecurity.RunWithElevatedPrivileges(delegate()
            {
                using (SPSite SiteMysite = new SPSite(SiteiD))
                {
                    using (SPWeb EvlWebHR = SiteMysite.OpenWeb(WebiD))
                    {
                        SPList GenInsuList = EvlWebHR.Lists["10KRunSurvey"];                        
                        SPListItemCollection items = GenInsuList.GetItems();                        
                        if (items.Count > 0)
                        {
                            dt10kRun = items.GetDataTable();
                        }
                    }
                }
            });
        }

        protected void UpdateMethod()
        {
            using (SPSite SiteMysite = new SPSite(SiteURL))
            {
                using (SPWeb EvlWebHR = SiteMysite.OpenWeb())
                {
                    EvlWebHR.AllowUnsafeUpdates = true;
                    SPList GenInsList = EvlWebHR.Lists["10KRunSurvey"];
                    SPListItem GenInsListItem = GenInsList.Items.Add();


                    GenInsListItem["Title"] = txtVAMID.Text;
                    GenInsListItem["Name"] = txtName.Text;
                    GenInsListItem["Email"] = sttEmail;
                    GenInsListItem["Designation"] = txtdesignation.Text;
                    GenInsListItem["Account"] = txtAccount.Text;
                    GenInsListItem["Department"] = txtDepartment.Text;
                    //GenInsListItem["RunType"] = rbType.SelectedValue;
                    GenInsListItem["Size"] = rbSize.SelectedValue;
                    GenInsListItem.Update();
                    EvlWebHR.AllowUnsafeUpdates = false;
                    lblErrorMessage.Text = "Successfully submitted.";
                    lblErrorMessage.ForeColor = System.Drawing.Color.Green;
                    btnsave.Visible = false;
                }
            }
        }

       
        }

        
    }


        