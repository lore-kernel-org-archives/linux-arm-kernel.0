From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Mar 2017 08:17:06 +0100
Subject: [PATCH v3 03/11] ARM: dts: sun8i: sina33: add cpu-supply
In-Reply-To: <CAGb2v67mihMMMqEpWSiuXXn6evXcquStGqQHRK2KdQzQ+EubNA@mail.gmail.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-4-quentin.schulz@free-electrons.com>
 <CAGb2v67mihMMMqEpWSiuXXn6evXcquStGqQHRK2KdQzQ+EubNA@mail.gmail.com>
Message-ID: <20170322071706.kzkw65653ivl4qcd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 11:33:15AM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > This adds the cpu-supply DT property to the cpu0 DT node needed by
> > the board to adapt the regulator voltage depending on the currently used
> > OPP.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/a13eb3a6/attachment.sig>
