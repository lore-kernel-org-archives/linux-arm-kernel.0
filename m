From: agross@codeaurora.org (Andy Gross)
Date: Tue, 10 Feb 2015 23:20:02 -0600
Subject: [Patch v2 1/2] dmaengine: Add ADM driver
In-Reply-To: <54CB6F67.9080600@smartplayin.com>
References: <1420687572-7116-1-git-send-email-agross@codeaurora.org>
 <1420687572-7116-2-git-send-email-agross@codeaurora.org>
 <54CB6F67.9080600@smartplayin.com>
Message-ID: <20150211052002.GA24943@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 05:17:51PM +0530, Pramod Gurav wrote:
> > +
> > +	achan = to_adm_chan(chan);
> Could not understand the use of achan here. unused code?

yeah its unnecessary now.  will remove.  Thanks!
> 
> > +

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
