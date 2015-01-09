From: agross@codeaurora.org (Andy Gross)
Date: Fri, 9 Jan 2015 11:13:56 -0600
Subject: [PATCH 1/2] soc: qcom: Add TCSR driver
In-Reply-To: <4757751.7cLGsvPiZX@wuerfel>
References: <1420757577-20425-1-git-send-email-agross@codeaurora.org>
 <1420757577-20425-2-git-send-email-agross@codeaurora.org>
 <4757751.7cLGsvPiZX@wuerfel>
Message-ID: <20150109171356.GC16970@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 01:06:56AM +0100, Arnd Bergmann wrote:
> On Thursday 08 January 2015 16:52:56 Andy Gross wrote:
> > This patch adds support for the TCSR (Top Control and Status Register) IP block
> > that is present in the Qualcomm IPQ8064, APQ8064, and some later processors.
> > This block contains additional configuration and mux settings for various
> > peripherals in the system, including the ADM DMA block and USB controller.
> > 
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > 
> 
> It sounds like this is a collection of random registers. Have you considered
> making it a syscon node instead?

That's a capital idea and solves my probe_defer issue more cleanly.  I'll rework
and resend.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
