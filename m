From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 11:14:18 -0800
Subject: [GIT PULL] ARM: mvebu: stable fix for v3.13
In-Reply-To: <20140114154452.GP19878@titan.lakedaemon.net> (Jason Cooper's
 message of "Tue, 14 Jan 2014 10:44:52 -0500")
References: <20140114154452.GP19878@titan.lakedaemon.net>
Message-ID: <87wqi274vp.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> And... despite typing the stable ML address quite often, I still got it
> wrong.  Need more coffee.
>
> thx,
>
> Jason.
>
> arm-soc folks,
>
> Sorry for the lateness in the window on this one.  I'd like to see it
> get into v3.13 if possible, but if it doesn't get there till v3.13.1, I
> understand.

Since it touches arch/arm, drivers, and bindings I'm a little reluctant
to take it in to v3.13 at this point since we're already at -rc8.  

I've merged it into next/fixes-non-critical so it goes in right away for
v3.14, and your stable tags will get it into v3.12+

Thanks,

Kevin
