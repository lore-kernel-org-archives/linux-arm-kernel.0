From: agross@codeaurora.org (Andy Gross)
Date: Wed, 28 Jan 2015 11:27:27 -0600
Subject: [PATCH 1/6] soc: qcom: gsbi: Add support for ADM CRCI muxing
In-Reply-To: <54C8A66E.3070306@mm-sol.com>
References: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
 <1422396644-21714-2-git-send-email-agross@codeaurora.org>
 <54C8A66E.3070306@mm-sol.com>
Message-ID: <20150128172727.GB17315@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 11:05:50AM +0200, Stanimir Varbanov wrote:
> <snip>
> 
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index 7bd2c94..32f20be 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -4,6 +4,7 @@
> >  config QCOM_GSBI
> >          tristate "QCOM General Serial Bus Interface"
> >          depends on ARCH_QCOM
> > +	select MFD_SYSCON
> 
> Wrong indentation? In fact the original Kconfig entry has spaces instead
> of tabs, could you prepare a cleanup patch for this.

yeah I'll switch to spaces since the Kconfig is using spaces.

> >          help
> >            Say y here to enable GSBI support.  The GSBI provides control
> >            functions for connecting the underlying serial UART, SPI, and I2C

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
