From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Jan 2013 18:43:52 +0100
Subject: [PATCH 3.9] Driver for 7-segment displays connected over GPIOs
In-Reply-To: <20130107184022.72b23aa9@skate>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130107164845.GA2911@kroah.com> <20130107180708.2ffc1540@skate>
 <20130107172340.GA32401@kroah.com> <20130107184022.72b23aa9@skate>
Message-ID: <20130107184352.2e90abfb@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 7 Jan 2013 18:40:22 +0100, Thomas Petazzoni wrote:

> > > Not having a kernel driver means that gazillions of applications
> > > re-invent the same piece of code over and over again, have to hardcode
> > > the GPIO numbers for a given piece of hardware, while the kernel
> > > abstract all of this very nicely.
> > 
> > That sounds like a wonderful use of a userspace library to do this
> > properly.  Much like libusb does, right?
> > 
> > I still think as this can be done in userspace, it probably should be.
> 
> Understood. Patches discarded.

Thinking more about this. How would your userspace library know on which
GPIOs your 7-seg segment device is connected? Should it parse the
Device Tree from userspace? Given by the user-space application who
would have to hardcode the GPIO numbers, completely defeating the
hardware abstraction layer that the kernel intends to be?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
