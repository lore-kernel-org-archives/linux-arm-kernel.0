From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Jun 2018 00:49:36 -0700
Subject: v4.18-rc1 on droid 4: very bad CPU performance
In-Reply-To: <20180622072005.GF112168@atomide.com>
References: <20180621121542.GA4836@amd> <20180622072005.GF112168@atomide.com>
Message-ID: <20180622074936.GG112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180622 07:22]:
> * Pavel Machek <pavel@ucw.cz> [180621 12:18]:
> > Hi!
> > 
> > V4.18 is slower than it should be.
> > 
> > user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> > | wc -c
> > 10044291
> > 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> > user at devuan:~$ uname -a
> > Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> > 19:26:37 CEST 2018 armv7l GNU/Linux
> > 
> > That bzip should take 12 seconds, not minute.
> > 
> > Any ideas? Do you see it, too?
> 
> I've noticed firefox is super slow.. Git bisect time?

Hmm not happening for me at least on duovero and droid4,
I'm getting about 20s for v4.17 and v4.18-rc1.

Regards,

Tony
