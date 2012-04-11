From: dsaxena@plexity.net (Deepak Saxena)
Date: Wed, 11 Apr 2012 11:21:59 -0700
Subject: [GIT PULL] ixp2xxx platform removal for 3.5
In-Reply-To: <4F7F2BC8.9040101@gmail.com>
References: <4F7F2BC8.9040101@gmail.com>
Message-ID: <20120411182159.GA12519@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr 06 2012, at 12:45, Rob Herring was caught saying:
> Arnd, Olof,
> 
> Please pull the ixp23xx and ixp2000 platform removal for 3.5. I've only
> included the arch/arm/* portion here. David Miller already picked up the
> net driver for net-next, and I'm assuming other subsystem maintainers
> will pick up i2c, mtd and watchdog patches. In any case, there aren't
> any ordering dependencies with the other patches.
> 
> Rob
> 
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> 
>   Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> 
> are available in the git repository at:
>   git://sources.calxeda.com/kernel/linux.git ixp2xxx-removal
> 
> Rob Herring (1):
>       ARM: remove ixp23xx and ixp2000 platforms

As the person who originally wrote much of this code (and is both
happy and sad to see it go):

Acked-by: Deepak Saxena <dsaxena@plexity.net>
