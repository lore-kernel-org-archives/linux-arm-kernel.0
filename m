From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 25 Jul 2015 08:33:04 +0200
Subject: [PATCH] drivers/reset: appropriate __init annotation for const
 data
In-Reply-To: <alpine.LFD.2.20.1507241531370.1806@knanqh.ubzr>
References: <alpine.LFD.2.20.1507241531370.1806@knanqh.ubzr>
Message-ID: <20150725063304.GJ2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, Jul 24, 2015 at 03:34:11PM -0400, Nicolas Pitre wrote:
> 
> Init data marked const should be annotated with __initconst for
> correctness and not __initdata.  This also fixes LTO builds that
> otherwise fail with section mismatch errors.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150725/2a99ea65/attachment.sig>
