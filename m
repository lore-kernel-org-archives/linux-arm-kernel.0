From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Nov 2012 23:23:00 -0800
Subject: [PATCH 0/3] ARM: zynq: ARCH_MULTIPLATFORM support
In-Reply-To: <CAHTX3d+YE7mtsQOdrBV4B=zp_CHSTrWbbXgjkBBkTeenv_4DHg@mail.gmail.com>
References: <cover.1353349191.git.josh.cartwright@ni.com>
 <CAHTX3d+YE7mtsQOdrBV4B=zp_CHSTrWbbXgjkBBkTeenv_4DHg@mail.gmail.com>
Message-ID: <20121121072300.GI7615@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 01:30:58PM +0100, Michal Simek wrote:
> Hi Josh, Arnd and Olof,
> 
> 2012/11/19 Josh Cartwright <josh.cartwright@ni.com>:
> > Michal-
> >
> > Here's an attempt at supporting ARCH_MULTIPLATFORM on Zynq.  I've gotten
> > a multiplatform kernel building and booting on the zc702, although I
> > haven't tried to boot the same image on another non-Zynq board, due to
> > lack of available hardware.
> >
> > It would be super awesome if this set could land in 3.8, but I know
> > we're running out of time there.  I wouldn't be too heartbroken if it
> > didn't make it.
> >
> > This patchset is on top of your arm-next branch and with the
> > debug_ll_init support patch @ arm-soc/devel/debug_ll_init.
> >
> > Patch 1 drops the early TTC mapping.  It is not necessary, since the TTC
> > driver now supports pulling mapping info from the device tree.
> >
> > Patch 2 converts zynq to use the debug_ll_init() infrastructure slated
> > to go into 3.8.
> >
> > Patch 3 is the bulk of the set, moving around logic around within
> > mach-zynq/include, and setting up the necessary build magic to get Zynq
> > building w/ CONFIG_ARCH_MULTIPLATFORM.
> >
> 
> I wanted to look at it too today. You were faster!
> I have tested your patches and all works for me.
> I have also added them to my arm-next branch.
> 
> I don't have others ARM boards to test but it shouldn't be big problem
> because others will test it.
> 
> We are out of merge window that's why we should wait to the next one.
> Anyway Arnd/Olof if there is any option to get this to v3.8, please let me know.

Feel free to post a pull request, if things look clean we can probably pick it up.


-Olof (playing good cop for once :-)
