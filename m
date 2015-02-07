From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 7 Feb 2015 16:44:09 +0100
Subject: [PATCH v4 0/5] ARM: sun9i: Add USB host controller support for A80
In-Reply-To: <1422915725-26492-1-git-send-email-wens@csie.org>
References: <1422915725-26492-1-git-send-email-wens@csie.org>
Message-ID: <20150207154409.GS2079@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 06:22:00AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v4 of the sun9i A80 USB host support series.
> 
> Changes since v3:
> 
>   - Dropped patches merged.
> 
>   - Moved reg_usb3_vbus into the optimus board dts
> 
>   - Dropped ohci1 from A80 dtsi.
> 
> Cover letter from v3:
> 
> This series adds USB host controller (EHCI/OHCI) support for the Allwinner
> A80 SoC. The A80 has 3 pairs of host controllers and USB PHYs. The PHYs,
> unlike in previous SoCs, do not have low level control registers anymore.
> 
> As such, this series forgoes the original phy-sun4i-usb driver, and adds
> a new, simpler driver for the USB PHYs. It may be possible to merge the
> two, but given that work is being done on the OTG front for the earlier
> SoCs, it may be better to merge them after support is complete.
> 
> EHCI/OHCI0 corresponds to USB1 DP/DM pins; EHCI1 only has HSIC support;
> EHCI2/OHCI/2 is USB2 DP/DM externally. External pins labeled USB0 are
> for the USB 3.0 OTG controller.

Applied 2-5.

Thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150207/03000403/attachment.sig>
