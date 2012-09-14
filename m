From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 10:02:30 +0100
Subject: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed via
 Device Tree
In-Reply-To: <20120914084141.GA2630@pengutronix.de>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
 <20120914084141.GA2630@pengutronix.de>
Message-ID: <20120914090228.GH3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > First, I'd like to have this patch squashed with "i2c: nomadik: Add
> > > Device Tree support to the Nomadik I2C driver". I wanted to do this on
> > > my own, but the patches do not apply to 3.6-rc5 (with or without
> > > regulator removal patch from Linus)?
> > 
> > I'm really not keen on squashing all my patches together. They are
> > clearly have very different purposes. If you think they are closely
> > related, then pull them in sequentially, but please don't squash
> > all my work into a single patch for no other reason than convenience.
> 
> I can't follow this reasoning. I never asked you to squash all patches,
> only those two needed to get proper device tree support. Why would you
> want to let the device being detected via DT and not scan the child
> nodes immediately?

Ah, sorry. That's my fault for rushing though my ridiculously bloated post-
vacation inbox. I *stupidly* thought you wanted me to squash two different
patches, rather than these two. As such I unreservedly retract my previous
statement. Yes, please squash.

> > > I can also take the I2C related changes to the devicetrees via my tree.
> > > This is not uncommon. Some people prefer to do this via their soc-trees,
> > > though. I don't care much since this is not really a hard dependency
> > > causing build failures or merge conflicts, but just needs a little extra
> > > time until the patches are all there...
> > 
> > It would be better for all the Device Tree changes go in as a single
> > patch-set. Again, I don't care where they go, so long as they go in
> > together. arm-soc seems like the most generic place for them to be
> > pulled into though.
> 
> This reasoning I can follow, but how should I know you aimed for that? I
> only saw a patch [3/3] in one series making the driver probable via DT
> and a patch [12/19] in another series to scan the child nodes. That's
> all the infos I got. Some more context would have been helpful. Is there
> a branch somewhere with all the things collected?

There will be. I'm currently just Ack collecting. 

In fact wait ...

<3 mins pass>

Now there is:
  git://git.linaro.org/people/ljones/linux-3.0-ux500.git preview-for-next

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
