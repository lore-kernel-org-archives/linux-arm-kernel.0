From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 15:07:35 +0200
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <20120424040520.GC26306@S2101-09.ap.freescale.net>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
 <20120423074702.GD24843@shlinux2.ap.freescale.net>
 <20120423144623.GU26306@S2101-09.ap.freescale.net>
 <20120424034010.GA32166@shlinux2.ap.freescale.net>
 <20120424040520.GC26306@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdZ0USvyvT-YB3=VM5rb3VQ9-kVRwarZL82jMCz4J_wgUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 6:05 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> For example, all available mxs pin configuration options are only 3,
> mA, voltage and pull-up, and they sit on different bit field of
> different registers. ?I feel much more comfortable with using properties
> rather than a raw value to represent them, while I feel the raw value
> binding makes some sense to imx, since it has many pin configuration
> options and all these options sit in one register.

Hm, that's pretty interesting - but are imx and mxs even going to use the
same driver then? Maybe I'm not following - are they similar
in all other aspects than for this pin config stuff?

Whether to use properties or raw values or not I cleverly leave up
to the platform to define and solve, unless they want to use
the generic pinprops library.

Yours,
Linus Walleij
