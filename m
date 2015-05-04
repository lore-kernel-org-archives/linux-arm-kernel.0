From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 May 2015 14:53:31 +0200
Subject: [PATCH v2 3/5] mfd: sun6i-prcm: Add support for PRCM found on
 Allwinner A80 SoC
In-Reply-To: <1430410206-4410-4-git-send-email-wens@csie.org>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
 <1430410206-4410-4-git-send-email-wens@csie.org>
Message-ID: <20150504125331.GB3274@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 12:10:04AM +0800, Chen-Yu Tsai wrote:
> This patch adds support for the PRCM on the A80 SoC. There is little
> to no document for this at the moment. Only register offsets are
> available. However with some testing, the clock and reset controls
> seem to be the similar to the ones on the A31.
> 
> One thing that needs verifying is whether the apbs divider is the same
> as the A31 or the A23. The lowest divider is different between those
> 2 implementations.

Is this commit log still true now that we have access to documentation
the PRCM?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150504/022c3510/attachment.sig>
