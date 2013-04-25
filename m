From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 25 Apr 2013 20:27:45 +0200
Subject: [PATCH] cpuidle: add maintainer entry
In-Reply-To: <CACRpkdaA8uG5jYyYTbuvzZNRr47EhWHFMLLz+jbiE3FPC1vjmA@mail.gmail.com>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
 <87k3nr50n4.fsf@linaro.org>
 <CACRpkdaA8uG5jYyYTbuvzZNRr47EhWHFMLLz+jbiE3FPC1vjmA@mail.gmail.com>
Message-ID: <9935265.yXMiRQV8Yo@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 25, 2013 02:09:11 PM Linus Walleij wrote:
> On Wed, Apr 24, 2013 at 6:55 PM, Kevin Hilman <khilman@linaro.org> wrote:
> > Rafael,
> >
> > Daniel Lezcano <daniel.lezcano@linaro.org> writes:
> >
> > [...]
> >
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 61677c3..effa0f3 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2206,6 +2206,13 @@ S:     Maintained
> >>  F:   drivers/cpufreq/
> >>  F:   include/linux/cpufreq.h
> >>
> >> +CPUIDLE DRIVERS
> >> +M:   Rafael J. Wysocki <rjw@sisk.pl>
> >> +L:   linux-pm at vger.kernel.org
> >> +S:   Maintained
> >> +F:   drivers/cpuidle/*
> >> +F:   include/linux/cpuidle.h
> >
> > What do you think about having Daniel listed here as a co-maintainer?
> 
> I second that. He will bring useful embedded knowledge to the
> subsystem.

I'd still like to have a say about the core, but if Daniel is willing to
maintain ARM cpuidle drivers and all of the relevant ARM people agree with
that, that'll be great.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
