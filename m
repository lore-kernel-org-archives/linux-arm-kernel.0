From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 22:36:19 +0800
Subject: [PATCH v5 04/22] dt-bindings: sram: sunxi: Add A13, A20, A23 and
 H3 dedicated bindings
In-Reply-To: <20180710080114.31469-5-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-5-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v65MO9xmKQz5LuydwqwvVB-_bbM=FeqbsRwJbh-5km9XCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 4:00 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> This introduces dedicated bindings for the system control blocks found
> on the A13, A20, A23 and H3 sunxi platforms.
>
> Since the controllers on the A33 are the very same as those on the A23,
> no specific compatible is introduced for it.
>
> These bindings are introduced to allow reflecting the differences that
> exist between these controllers, that may become significant to driver
> implementations.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Not sure if there's a difference between A10 and A20, if you don't count
the NMI that we have a separate node for. But anyway,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
