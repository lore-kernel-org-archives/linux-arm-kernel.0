From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Apr 2013 11:10:18 +0100
Subject: [Suggestion] ARM:S5pv210: compiling issue for s5pv210 by using
 randconfig
In-Reply-To: <515BFA8D.2000204@asianux.com>
References: <514FB202.3040807@asianux.com>
 <515BFA8D.2000204@asianux.com>
Message-ID: <20130403101018.GE11040@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 10:46:53AM +0100, Chen Gang wrote:
> Hello Maintainers:
> 
>   when you have time, could you help to check this suggestion ?

[...]

> > 
> >   make:
> >     make V=1 EXTRA_CFLAGS=-W ARCH=arm randconfig
> >     make V=1 EXTRA_CFLAGS=-W ARCH=arm menuconfig
> >       set arm-linux-gnu-  for "Cross-compiler tool prefix"
> >       set "Samsung S5PV210/S5PC210" for "ARM system type"
> >     make V=1 EXTRA_CFLAGS=-W ARCH=arm

I think the main problem is that you've reported an issue created from a
randconfig, but you haven't made the config in question available.

Will
