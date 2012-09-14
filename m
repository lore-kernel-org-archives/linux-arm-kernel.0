From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Sep 2012 16:54:08 +0200
Subject: [PATCH v3 2/5] Documentation: add description of DT binding for
 the gpio-mvebu driver
In-Reply-To: <CACRpkdY3ePZLUJsX_X9QGyo6dCDmweUd5Lq7BYnQ4P0uGVj-uQ@mail.gmail.com>
References: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347551658-24449-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <50524026.20104@gmail.com> <20120913223059.2d0606b2@skate>
 <50524363.9070100@gmail.com>
 <CACRpkdY3ePZLUJsX_X9QGyo6dCDmweUd5Lq7BYnQ4P0uGVj-uQ@mail.gmail.com>
Message-ID: <20120914165408.4beaefe7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Linus Walleij,

On Fri, 14 Sep 2012 15:17:09 +0200, Linus Walleij wrote:

> >> Yes, I know, but MAINTAINERS does not mention an alternate maintainer
> >> for the GPIO subsystem. Who is the interim maintainer that will
> >> ultimately have to ack/nack those patches?
> >
> > Linus W. is.
> 
> I stated Reviewed-by: on the GPIO patch, please merge it through the
> Marvell tree (I guess that's the plan?)

Yes, I guess it's the easiest plan (Jason ? Andrew ?). We however need
Acks on the pinctrl patch series as well, since this one depends on it.

Thanks a lot for your review!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
