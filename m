From: agross@codeaurora.org (Andy Gross)
Date: Wed, 11 Feb 2015 22:47:48 -0600
Subject: [Patch v3 2/2] dmaengine: Add ADM driver
In-Reply-To: <20150212012814.GI11190@codeaurora.org>
References: <1423634619-614-1-git-send-email-agross@codeaurora.org>
 <1423634619-614-3-git-send-email-agross@codeaurora.org>
 <20150212012814.GI11190@codeaurora.org>
Message-ID: <20150212044748.GB29515@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 05:28:14PM -0800, Stephen Boyd wrote:
> On 02/11, Andy Gross wrote:
> > +static struct platform_driver adm_dma_driver = {
> > +	.probe = adm_dma_probe,
> > +	.remove = adm_dma_remove,
> > +	.driver = {
> > +		.name = "adm-dma-engine",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = adm_of_match,
> > +	},
> > +};
> 
> The THIS_MODULE script will find you. Am I a script?

darn it.  I skimmed right over that.  I'll resend.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
