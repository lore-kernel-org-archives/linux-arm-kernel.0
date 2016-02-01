From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Feb 2016 21:24:58 +0100
Subject: [PATCH RFC 11/11] clk: sunxi: rewrite sun8i-a23-mbus-clk using
 the simpler composite clk
In-Reply-To: <CAGb2v658SFy6SF87=obYLW1YAxvk0T4dRuBU-F1oLT3Yq=PgTQ@mail.gmail.com>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-12-git-send-email-wens@csie.org>
 <20160127174932.GP4317@lukather>
 <CAGb2v658SFy6SF87=obYLW1YAxvk0T4dRuBU-F1oLT3Yq=PgTQ@mail.gmail.com>
Message-ID: <20160201202458.GJ4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 28, 2016 at 10:41:33AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Jan 28, 2016 at 1:49 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Jan 25, 2016 at 09:15:47PM +0800, Chen-Yu Tsai wrote:
> >> sun8i-a23-mbus-clk used sunxi's factors clk, which is nice for very
> >> complicated clocks, but is not really needed here.
> >>
> >> Convert sun8i-a23-mbus-clk to use clk_composite, as it is a gate + mux
> >> + divider. This makes the code easier to understand.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Applied, thanks!
> > Maxime
> 
> Given your suggestion for extending and generalizing factors clk
> clock rate calculations, maybe we just leave this one out and use
> the new stuff later?

My suggestion was only about the core of the clk-factors, the
"external" API would not change, so I'm guessing it's still relevant.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/78d4db1a/attachment.sig>
