From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jun 2013 10:41:06 +0200
Subject: [PATCH 2/6] pinctrl: sunxi: Move the pins definitions to a
 separate header
In-Reply-To: <CACRpkdajdrcLy6u2cKkrpYnh0Hqx8Hjx+zJ_tfpYCfJFqWCrZA@mail.gmail.com>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
 <1370795767-9769-3-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdajdrcLy6u2cKkrpYnh0Hqx8Hjx+zJ_tfpYCfJFqWCrZA@mail.gmail.com>
Message-ID: <20130617084106.GE16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Jun 16, 2013 at 01:03:09PM +0200, Linus Walleij wrote:
> On Sun, Jun 9, 2013 at 6:36 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > It will allow us to have a cleaner separation between the data needed by
> > the driver to work, and the core logic of the driver in itself, and will
> > allow having too much noise in the core driver in the future.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Patch applied.
> 
> Since you will anyway have to bring the ARM SoC branch on
> top of the pinctrl tree, I might as well apply this to my tree.

Thanks for merging this.

I applied the other patches except for the 5th one that Emilio commented
on.

> If everything else fails, you'll have a nice development base
> in v3.11 with this in place, right?

Yes, As far as I can see, we should have a pretty complete support for
the GPIO/muxing/IRQ on the "old" allwinner SoCs (sun4i and sun5i) now.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
