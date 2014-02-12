From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 12 Feb 2014 11:56:54 +0000
Subject: [PATCH 02/12] power/reset: vexpress: Use udelay instead of timers
In-Reply-To: <201402112159.16758.arnd@arndb.de>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-3-git-send-email-pawel.moll@arm.com>
 <201402112159.16758.arnd@arndb.de>
Message-ID: <1392206214.848.19.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-11 at 20:59 +0000, Arnd Bergmann wrote:
> On Tuesday 11 February 2014, Pawel Moll wrote:
> > At this stage of system shutdown procedure the jiffies may
> > not be updated anymore, so just use udelay instead.
> 
> comment doesn't match code: s/udelay/mdelay/
> 
> > +                       mdelay(1000);
> >         }

Uh, right. Well spotted. Will fix.

Pawel
