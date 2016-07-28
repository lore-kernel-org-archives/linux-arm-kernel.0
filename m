From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jul 2016 15:31:45 +0200
Subject: [PATCH 8/9] clk: sunxi-ng: Add A31/A31s clocks
In-Reply-To: <1469516671-19377-9-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-9-git-send-email-wens@csie.org>
Message-ID: <20160728133145.GB6682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 03:04:30PM +0800, Chen-Yu Tsai wrote:
> Add a new style driver for the clock control unit in Allwinner A31/A31s.
> 
> A few clocks are still missing:
> 
>     - EMAC clock
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Looks good to me, aside from the comment made by Jean-Francois.

I guess I'd prefer to have the SoC names in the define, just in case
we need to introduce support for another SoC, but this can always be
done later.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/34b3f29b/attachment.sig>
