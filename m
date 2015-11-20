From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Nov 2015 12:17:04 +0100
Subject: [PATCH v3 8/9] ARM: sunxi_defconfig: Update MFD_AXP20X symbol
 and enable MFD_AXP20X_RSB
In-Reply-To: <1447691908-25456-9-git-send-email-wens@csie.org>
References: <1447691908-25456-1-git-send-email-wens@csie.org>
 <1447691908-25456-9-git-send-email-wens@csie.org>
Message-ID: <20151120111704.GX32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 12:38:27AM +0800, Chen-Yu Tsai wrote:
> axp20x support has been split into 2 parts, I2C and RSB interface
> variants.
> 
> Update the MFD_AXP20X symbol for I2C support, and also enable
> MFD_AXP20X_RSB to support RSB variants.
> 
> Keep MFD_AXP20X enabled for now, to ease migration for automated boot
> farms while the patches are being merged. This should be removed in the
> next release.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/eb7c6e47/attachment.sig>
