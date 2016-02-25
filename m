From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 16:55:43 -0800
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.6 (#1)
In-Reply-To: <878u2js4cn.fsf@free-electrons.com>
References: <878u2js4cn.fsf@free-electrons.com>
Message-ID: <20160225005543.GA29055@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 05:12:40PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for arm64 for mvebu for v4.6. It is even
> the first pull request ever for arm64 for us. Let me know if I am doing
> it wrong.
> 
> I split my initial series[1] in two parts: device tree related and non
> device tree related. I will also let the driver maintainers directly
> take the related patch for ATA and serial.
> 
> For this non device tree part I have a dependency with the irchip
> subsystem. For this I based on the irqchip/mvebu immutable branch form
> Jason Cooper located at git://git.infradead.org/users/jcooper/linux.git.
> 
> Thanks,
> 
> Gregory
> 
> [1]: https://lkml.org/lkml/2016/2/16/735
> 
> The following changes since commit 63131b636a0ec969e8b98122c1a928b5a2649d3b:
> 
>   irqchip/armada-370-xp: Do not enable it by default when ARCH_MVEBU is selected (2016-02-16 18:11:39 +0000)

PLease do this by explicit merge instead in the future, so it's obvious that
there is an external branch merged in history later.

That way, doing the full diffstat including the merge is just fine too.


> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.6-1
> 
> for you to fetch changes up to e772ca05cceb1480bdc7a7579e042b18558d0959:
> 
>   arm64: defconfig: enable Armada 3700 related config (2016-02-17 16:23:20 +0100)

Merged, thanks!


-Olof
