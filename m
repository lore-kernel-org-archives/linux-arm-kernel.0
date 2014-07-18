From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jul 2014 22:38:37 +0200
Subject: [PATCH v2 0/5] ARM: dts: sun6i: Add support for GMAC
In-Reply-To: <1405444547-21870-1-git-send-email-wens@csie.org>
References: <1405444547-21870-1-git-send-email-wens@csie.org>
Message-ID: <20140718203837.GL20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 16, 2014 at 01:15:42AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This is v2 of the A31 GMAC support series. The GMAC is the same as in
> the A20, except it has an extra reset control. The GMAC clock module is
> mostly the same as in the A20, without the extra dividers, which I left
> out intentionally from the clock driver.
> 
> The register offsets and interrupts were copied from A31 SDK in Rhombus
> Tech's repository. The pin muxes were from the EVB fex file.
> 
> I've tested this on my A31 Hummingbird under 100M and 1000M.
> 
> Patch 5 adds support for the A31 Hummingbird. It is based on your work,
> so it has your name on it. I cleaned up the format and descriptions,
> got rid of missing devices, and added usb and the external rtc. 

Applied all the patches. Thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/5e1fdf7b/attachment.sig>
