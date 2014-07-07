From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Jul 2014 10:55:03 +0200
Subject: [PATCH v3 4/9] mfd: sun6i-prcm: Add support for Allwinner A23 PRCM
In-Reply-To: <1404399349-20237-5-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-5-git-send-email-wens@csie.org>
Message-ID: <20140707085503.GF16262@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 10:55:44PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> The differences are the AR100 clock can no longer be modified,
> the APB0 clock has different divisors, and some clock gates are
> gone.
> 
> This patch adds a compatible with a modified subdevice list for
> the A23.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/72d8109d/attachment.sig>
