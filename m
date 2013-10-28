From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Oct 2013 13:35:42 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.13 (last round)
In-Reply-To: <20131023113237.GG24520@titan.lakedaemon.net>
References: <20131023113237.GG24520@titan.lakedaemon.net>
Message-ID: <20131028173542.GA26663@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Wed, Oct 23, 2013 at 07:32:37AM -0400, Jason Cooper wrote:
> Guys,
> 
> I've held off several patches for the next window (nothing big),
> however, MikeT just took Ezequiel's clock divider driver for v3.13.  So,
> to keep things in sync, I'd appreciate it if you could take this last
> pull request containing only the corresponding dts and binding changes
> for that driver.

I saw you handled a round of pull requests for v3.13 yesterday, did you
miss this one?

thx,

Jason.

> The following changes since commit 1deb122c724edfd799a4d7d0b88ff14c365c9e69:
> 
>   ARM: Dove: fix bad properties of the si5351 clkout2 used by Cubox audio (2013-10-09 13:22:41 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/dt-3.13-4
> 
> for you to fetch changes up to f039dfb51b36a2d7e4ac25e65ffbd03e3ac77a0c:
> 
>   ARM: mvebu: Add the core-divider clock to Armada 370/XP (2013-10-23 11:04:31 +0000)
> 
> ----------------------------------------------------------------
> mvebu dt changes for v3.13 (round 4)
> 
>  - mvebu
>     - core divider clock driver dt binding and nodes
> 
> ----------------------------------------------------------------
> Ezequiel Garcia (3):
>       ARM: mvebu: Add Core Divider clock device-tree binding
>       ARM: mvebu: Add a 2 GHz fixed-clock Armada 370/XP
>       ARM: mvebu: Add the core-divider clock to Armada 370/XP
> 
>  .../devicetree/bindings/clock/mvebu-corediv-clock.txt | 19 +++++++++++++++++++
>  arch/arm/boot/dts/armada-370-xp.dtsi                  | 17 +++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
