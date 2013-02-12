From: wolfram@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Feb 2013 11:03:35 +0100
Subject: [RFC] i2c: Providing hooks for i2c multimaster bus arbitration.
In-Reply-To: <CAPnjgZ3HnXDp9ErsbZEfpc-NexuAt1C5cUWbFn=BW2TMGiMJEg@mail.gmail.com>
References: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
 <20130210181710.GB12760@nekote.pengutronix.de>
 <CAD=FV=XzfseMEHK4KutgYYoU4kEFPq7qoFoJtaBrh6QJUa1Y_w@mail.gmail.com>
 <CAPnjgZ3HnXDp9ErsbZEfpc-NexuAt1C5cUWbFn=BW2TMGiMJEg@mail.gmail.com>
Message-ID: <20130212100335.GA5490@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > At the moment perhaps the strongest argument for why this particular
> > arbitration scheme is needed is that's what the EC (embedded
> > controller) on the ARM Chromebook uses.  There have been several
> > arguments in-house about whether this was the most ideal way to
> > structure things, but that's what we shipped with.  Thus, if we want
> > to be able to talk to i2c devices on this bus (contains the keyboard,
> > battery, and a bunch of power switches) we need something in the
> > system that implements this arbitration scheme.
> >
> 
> There was some discussion about using the built-in I2C multi-master
> support but no one had had a good experience getting it to work
> reliably in a real system so we ended up deciding not to rely on this.

So, were there no experiences at all or bad experiences when trying? I
am interested in hearing what I2C multi master restrictions might exist
in practice.

Thanks,

   Wolfram
