From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Jan 2016 11:37:57 +0100
Subject: [PATCH v3 1/2] clk: sunxi: factors: Add missing recalc pointer
 copy
In-Reply-To: <CAGb2v66dbtBPwRQzA3rtP5hu-0rvfaX2ac7KWRiF42wtEiafwg@mail.gmail.com>
References: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66dbtBPwRQzA3rtP5hu-0rvfaX2ac7KWRiF42wtEiafwg@mail.gmail.com>
Message-ID: <20160129103756.GC32462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 02:18:34PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jan 29, 2016 at 3:22 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Commit 4a9b2abc213e ("clk: sunxi: factors: Support custom formulas") was
> > introducing a custom recalc function. However, the pointer was never
> > filled, which was making the whole thing unused.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> (facepalm)
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> Can you squash it into the original?

I just did, and pushed the updated branches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/179815da/attachment.sig>
