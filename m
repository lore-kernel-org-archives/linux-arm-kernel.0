From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 17 Oct 2013 15:00:55 -0700
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.13 (round 2)
In-Reply-To: <20131017133944.GF22434@titan.lakedaemon.net> (Jason Cooper's
 message of "Thu, 17 Oct 2013 09:39:44 -0400")
References: <20131017133944.GF22434@titan.lakedaemon.net>
Message-ID: <87wqlbzhew.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> Guys,
>
> Here's the next round of driver changes for mvebu.  As previously
> arranged with Bjorn, we're taking the pci-mvebu.c changes this time
> around since the previous pull request had pci changes depending on
> changes in irqchip.

Luckily, I remember you pointed us to the discussions where Bjorn agreed
with the approach in the first round, but my brain prefers forgetting
things to remembering them so in the future, please try and get his ack
on the drivers/pci changes so we don't have to rely on my memory to go
wading through the archives.

> The following changes since commit 96ae0b548672adc12431312718835e77472f5bf0:
>
>   ARM: mvebu: fix gated clock documentation (2013-10-08 15:17:56 +0000)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/drivers-3.13-2
>
> for you to fetch changes up to f5072dfbac053200c8865c4fb15e4f020b7b5d1d:
>
>   PCI: mvebu: make local functions static (2013-10-08 17:57:40 +0000)
>
> ----------------------------------------------------------------
> mvebu driver changes for v3.13 (round 2)
>
>  - mvebu
>     - pcie
>        - dynamic link up detection
>        - add IO wrappers
>        - declare some local functions static
>
> ----------------------------------------------------------------

Pulled into next/drivers.

Thanks,

Kevin
