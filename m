From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Apr 2013 11:47:00 -0400
Subject: [PATCH v4 0/5]  LPAE remaining device tree file
In-Reply-To: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130415154700.GF28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 04:29:05PM +0200, Gregory CLEMENT wrote:
> Hi Jason,
> 
> I have just rebased the commits that you haven't applied yet. They are
> rebased on mvebu/dt. I check that all the dtb can be built.
> 
> Thanks,
> 
> Gregory CLEMENT (3):
>   ARM: dts: mvebu: Convert all the mvebu files to use the range
>     property
>   ARM: dts: mvebu: introduce internal-regs node
>   ARM: dts: mvebu: Convert mvebu device tree files to 64 bits
> 
> Thomas Petazzoni (2):
>   ARM: dts: mvebu: fix cpus section indentation
>   ARM: dts: mvebu: move all peripherals inside soc
> 
>  arch/arm/boot/dts/armada-370-db.dts              |  134 +++---
>  arch/arm/boot/dts/armada-370-mirabox.dts         |  176 ++++----
>  arch/arm/boot/dts/armada-370-rd.dts              |   96 ++---
>  arch/arm/boot/dts/armada-370-xp.dtsi             |  336 +++++++--------
>  arch/arm/boot/dts/armada-370.dtsi                |  330 +++++++--------
>  arch/arm/boot/dts/armada-xp-db.dts               |  202 ++++-----
>  arch/arm/boot/dts/armada-xp-gp.dts               |  222 +++++-----
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi         |  284 ++++++-------
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi         |  342 +++++++--------
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi         |  484 +++++++++++-----------
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  262 ++++++------
>  arch/arm/boot/dts/armada-xp.dtsi                 |  202 ++++-----
>  12 files changed, 1549 insertions(+), 1521 deletions(-)

whole series applied to mvebu/dt

thx,

Jason.
