From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Feb 2012 23:49:21 +0100
Subject: [PATCH 2/2] pinctrl: Add simple pinmux driver using device tree
 data
In-Reply-To: <20120203205508.4089.35304.stgit@kaulin.local>
References: <20120203205049.4089.74610.stgit@kaulin.local>
 <20120203205508.4089.35304.stgit@kaulin.local>
Message-ID: <CACRpkdaDOZ3X0AkWH4B4ZGCXHPxh0CkSg3xi=jHC5L+kJr1d=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2012 at 9:55 PM, Tony Lindgren <tony@atomide.com> wrote:

> Add simple pinmux driver using device tree data.
>
> Currently this driver only works on omap2+ series of
> processors, where there is either an 8 or 16-bit mux
> register for each pin. Support for other similar pinmux
> controllers could be added.

So since it's not named pinctrl-omap I guess you intend it
to be fully generic for simple muxes, which is nice!
If people start ACK:ing this I will be happy with it too,
because it's very easy to understand.

> Note that this patch does not yet support pinconf_ops
> or GPIO. Further, alternative mux modes are not yet
> handled.

Do you want to evolve the patch for these features
or do you want to refactor it in later?

Yours,
Linus Walleij
