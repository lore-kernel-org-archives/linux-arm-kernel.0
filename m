From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 20:36:11 +0200
Subject: [RESEND][PATCH] ARM: sun5i: Fix typo in trip point temperature
In-Reply-To: <d936e96e-7c2f-0607-0b04-3adfcdcadf98@bonstra.fr.eu.org>
References: <d936e96e-7c2f-0607-0b04-3adfcdcadf98@bonstra.fr.eu.org>
Message-ID: <20160822183611.GZ7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 08:34:07PM +0200, Hugo Grostabussiat wrote:
> Set cpu_alert0 temperature to 85?C instead of 850?C.
> 
> Fixes: 32a5d2d170cc ("ARM: dts: sun5i: Add cpu thermal zones to dtsi")
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks, applied.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/427bf95f/attachment.sig>
