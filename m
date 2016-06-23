From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Jun 2016 14:01:26 +0200
Subject: [PATCH v2] ARM: dts: sun5i: q8-common: Enable USB-based WiFi
In-Reply-To: <1466674155-3365-1-git-send-email-wens@csie.org>
References: <1466674155-3365-1-git-send-email-wens@csie.org>
Message-ID: <20160623120126.GB3785@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2016 at 05:29:15PM +0800, Chen-Yu Tsai wrote:
> The early A13 Q8 tablets all use a Realtek WiFi module connected to
> USB1. The module is powered by AXP209's LDO3 at 3.3V.
> 
> Move the related settings from sun5i-a13-q8-tablet.dts to
> sun5i-q8-common.dtsi, for all q8-based tablets.
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/810d4e65/attachment.sig>
