From: agross@codeaurora.org (Andy Gross)
Date: Thu, 8 Jan 2015 11:19:46 -0600
Subject: [Patch v2 2/2] dt/bindings: qcom_adm: Fix channel specificers
In-Reply-To: <54AEAFB6.9050609@codeaurora.org>
References: <1420687572-7116-1-git-send-email-agross@codeaurora.org>
 <1420687572-7116-3-git-send-email-agross@codeaurora.org>
 <54AEAFB6.9050609@codeaurora.org>
Message-ID: <20150108171946.GA15842@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 11:26:30AM -0500, Christopher Covington wrote:

<snip>

> > +DMA clients must use the format descripted in the dma.txt file, using a two
> >  cell specifier for each channel.
> >  
> >  Each dmas request consists of 3 cells:
> 
> Now 2 cells?

Good catch.  I'll fix in next rev.  Thanks!

> >   1. phandle pointing to the DMA controller
> >   2. channel number
> > - 3. CRCI assignment, if applicable.  If no CRCI flow control is required, use 0.
> > -    The CRCI is used for flow control.  It identifies the peripheral device that
> > -    is the source/destination for the transferred data.
> >  

<snip>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
