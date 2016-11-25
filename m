From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Nov 2016 13:57:26 +0100
Subject: [PATCH v2 1/8] mfd: sun6i-prcm: Add codec analog controls
 sub-device for Allwinner A23
In-Reply-To: <20161125123442.28410-2-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
 <20161125123442.28410-2-wens@csie.org>
Message-ID: <20161125125726.fsvldqhustgfpv7a@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 08:34:35PM +0800, Chen-Yu Tsai wrote:
> The PRCM block on the A23 contains a message box like interface to
> the registers for the analog path controls of the internal codec.
> 
> Add a sub-device for it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/37ff111a/attachment.sig>
