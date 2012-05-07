From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 May 2012 10:35:55 -0700
Subject: [PATCH 10/13] ARM: OMAP5: board-generic: Add device tree support.
In-Reply-To: <CAJ7qFSdBz1ccp0Z-4pWvbq0J0zb6j3Kto4cDz3R0kHT7YfRo0w@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-11-git-send-email-r.sricharan@ti.com>
 <4FA7CDC1.9050301@ti.com>
 <CAJ7qFSdBz1ccp0Z-4pWvbq0J0zb6j3Kto4cDz3R0kHT7YfRo0w@mail.gmail.com>
Message-ID: <20120507173555.GD5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* R, Sricharan <r.sricharan@ti.com> [120507 07:12]:
> Hi Benoit,
>   Thanks for the reviews.
> 
> >
> >> Adding the minimal support for OMAP5 soc with device tree.
> >
> >
> > You should probably split that patch since you are doing several things that
> > are not OMAP5 related.
> >
> > Do a patch that move the omap_init_irq into the INTC and GIC code first.
> >
> > Then, you can add a patch to add the OMAP5_DT machine entry.
> >
>   ok, will split this then accordingly.

Thanks, that allows us to remove the dependencies that will easily
cause merge errors adding let's say am33xx here.

Tony
