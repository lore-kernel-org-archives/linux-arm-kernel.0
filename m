From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 08:41:38 +0000
Subject: [PATCH 1/1] ARM: tegra: Add Tegra Memory Controller(MC) driver
In-Reply-To: <20120504083424.0f394a6db8e95763e59ae2a0@nvidia.com>
References: <1336063897-12083-1-git-send-email-hdoyu@nvidia.com>
 <CAOesGMivxdDhkEoZh=LuvtKRPfgXi=8X4chEL-cJazjgeo_ONA@mail.gmail.com>
 <20120504083424.0f394a6db8e95763e59ae2a0@nvidia.com>
Message-ID: <201205040841.39351.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Hiroshi Doyu wrote:
> > Since tegra has a custom memory controller it's not as obvious that it
> > needs to go in a shared location, indeed. But it's easier to use the
> > same practices across platforms, and if there are other vendors that
> > end up sharing IP blocks for memory down the road, having them in a
> > common location makes sense.
> 
> I think that the above TI's patch is:
> 
>   Add TI EMIF SDRAM controller driver
>     http://lwn.net/Articles/494922/
> 
> I'm moving this Tegra MC driver under drivers/memory, "tegra{20,30}-mc.c".

Ok, very good!

	Arnd
