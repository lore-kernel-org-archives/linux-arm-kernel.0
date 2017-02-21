From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 15:02:33 -0800
Subject: [PATCH 3/9] pinctrl: sunxi: add support for R40 pinctrl
In-Reply-To: <20170217173722.6477-4-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
 <20170217173722.6477-4-icenowy@aosc.xyz>
Message-ID: <20170221230233.2o4idjwybmkkakcs@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 18, 2017 at 01:37:16AM +0800, Icenowy Zheng wrote:
> Allwinner R40 have a pin controller similar to A20, only added 8-bit
> eMMC function to mmc2 at PC bank.
> 
> Add support for it in the already renamed sunxi-a20-r40 driver via
> variant framework.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

I think a prerequisite would be to merge A10 as well (possibly even
the other way around: A20 and R40 into the A10 driver).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/893391fb/attachment.sig>
