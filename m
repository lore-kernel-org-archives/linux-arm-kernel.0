From: agross@codeaurora.org (Andy Gross)
Date: Fri, 9 Jan 2015 11:10:21 -0600
Subject: [PATCH 1/2] soc: qcom: Add TCSR driver
In-Reply-To: <54AF1540.6090800@codeaurora.org>
References: <1420757577-20425-1-git-send-email-agross@codeaurora.org>
 <1420757577-20425-2-git-send-email-agross@codeaurora.org>
 <54AF1540.6090800@codeaurora.org>
Message-ID: <20150109171021.GB16970@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 03:39:44PM -0800, Stephen Boyd wrote:
> On 01/08/2015 02:52 PM, Andy Gross wrote:
> > +
> > +static struct platform_driver qcom_tcsr_driver = {
> > +	.driver = {
> > +		.name		= "tcsr",
> > +		.owner		= THIS_MODULE,
> 
> This is done by the module_platform_driver() macro now so it's largely
> unnecessary. Best to remove it so that the janitors don't find you!

Old habits die hard......

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
