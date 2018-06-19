From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Jun 2018 23:50:18 -0700
Subject: [PATCH 01/10] ARM: OMAP1: ams-delta: drop GPIO lookup table for
 serio device
In-Reply-To: <20180613044152.GB112168@atomide.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180612222356.GD38773@dtor-ws> <69494657.T0PeNZxiFJ@z50>
 <20180613044152.GB112168@atomide.com>
Message-ID: <20180619065018.GX112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180613 04:44]:
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [180613 01:18]:
> > On Wednesday, June 13, 2018 12:23:56 AM CEST Dmitry Torokhov wrote:
> > > Hi Janusz,
> > > 
> > > On Sat, Jun 09, 2018 at 04:02:15PM +0200, Janusz Krzysztofik wrote:
> > > > GPIO lookup table for ams-delta-serio device was introduced by commit
> > > > 0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables").
> > > > Unfortunately, a follow up patch "Input: ams_delta_serio: use GPIO
> > > > lookup table" was not accepted by subystem maintainer who requested
> > > > conversion of the driver to a platform driver, replacepemnt of IRQ GPIO
> > > > pin with IRQ resource, replacement of GPIO pin providing keyboard power
> > > > with a regulator and removal of remaining GPIO pins from the driver as
> > > > not handled by it.
> > > > 
> > > > Let's start with removal of no the longer needed GPIO lookup table from
> > > > the board init file.
> > > > 
> > > > Series created and tested on top of next-20180608 tag from linux-next
> > > > tree.
> > > 
> > > This all is really nice (modulo a couple of questions), thank you for
> > > implementing this. How do you want to merge this? Through OMAP tree or
> > > input?
> > 
> > Hi Dmitry,
> > 
> > If Tony doesn't mind, I would prefer it merged through OMAP tree as I still 
> > have a few board patches built on top of it in my queue.
> 
> Works for me once Dmitry is happy with the patches.

And please repost the whole series with acks collected so
I know what I need to apply :)

Regards,

Tony
