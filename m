From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 29 Dec 2014 09:51:50 +0800
Subject: [PATCH v3 0/4] Add basic support for Mediatek MT8173 SoC
In-Reply-To: <1419582417-4448-1-git-send-email-eddie.huang@mediatek.com>
References: <1419582417-4448-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1419817910.2371.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for my IT setting issue that accidentally add mediatek
confidential notice in the tail of this mail series.
Please skip it, and if anyone have concern, I can resend it.

> 
>  Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
>  arch/arm64/Kconfig                                 |   6 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/mediatek/Makefile              |   5 +
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  34 +++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 159 +++++++++++++++++++++
>  arch/arm64/configs/defconfig                       |   2 +
>  drivers/irqchip/irq-mtk-sysirq.c                   |  18 ++-
>  8 files changed, 222 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/Makefile
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173.dtsi
> 
> --
> 1.8.1.1.dirty
> 
> ************* Email Confidentiality Notice ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe 
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
