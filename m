From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jan 2014 23:41:59 +0100
Subject: [PATCH v2 2/8] clk: sunxi: choose correct name for multiple
 output factor clocks
In-Reply-To: <20140107221646.GF3103@lukather>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
 <1388987892-23733-3-git-send-email-wens@csie.org>
 <20140107221646.GF3103@lukather>
Message-ID: <20140107224159.GJ3103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 11:16:46PM +0100, Maxime Ripard wrote:
> On Mon, Jan 06, 2014 at 01:58:06PM +0800, Chen-Yu Tsai wrote:
> > Some factor clocks, such as the parent clock of pll5 and pll6, have
> > multiple output names. Use the last name as the name for the clock
> > itself.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Mike, Emilio,
> 
> This changes the clock names with regard to the previous patches
> emilio sent that will be merged in 3.14. It would be great if we could
> merge this in 3.14 as well.

I've spoken a bit too fast on this, and I'm not really fond of the
patch 7 i've commented on, that depends on what is done in this patch.

We'll see what the outcome of the discussion is.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/b17944c8/attachment.sig>
