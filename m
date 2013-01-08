From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Jan 2013 10:20:06 -0800
Subject: [GIT PULL] few omap fixes for v3.8-rc2
In-Reply-To: <CAOesGMhyYQoFYzqopGgwDwEVc4Gc74ERbRiJg_vhTmYf+V3_rA@mail.gmail.com>
References: <20130108174816.GP14149@atomide.com>
 <CAOesGMhyYQoFYzqopGgwDwEVc4Gc74ERbRiJg_vhTmYf+V3_rA@mail.gmail.com>
Message-ID: <20130108182005.GR14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130108 10:04]:
> On Tue, Jan 8, 2013 at 9:48 AM, Tony Lindgren <tony@atomide.com> wrote:
> > The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:
> >
> >   Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8-rc2/fixes-signed-v2
> >
> > for you to fetch changes up to 6adba67eb0c4731ed0346731d024b2102f5b4d9d:
> >
> >   ARM: OMAP2+: am33xx-hwmod: Fix wrongly terminated am33xx_usbss_mpu_irqs array (2013-01-07 12:38:07 -0800)
> >
> > ----------------------------------------------------------------
> > The biggest change is a fix to deal with different power state
> > on omap2 registers that causes issues trying to use common PM code.
> > Also fix few incorrect registers, and an issue for omap1 USB, and
> > few sparse fixes for issues that sneaked in with all the clean-up.
> 
> Pulled, thanks. Not super-happy about the 100+ line delta for the 24xx
> bugfix, but seems like it's needed.

Yes sorry looks like Paul was attempting to drop the omap custom PM
changes related to the drivers/i2c/bus/i2c-omap.c revert mess, but
naturally it's now too late. AFAIK that patch could wait for v3.9
too if necessary.

Regards,

Tony
