From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 14:48:17 -0700
Subject: [GIT PULL] ARM: mvebu: dt for v4.7 (#1)
In-Reply-To: <87oa9ljolv.fsf@free-electrons.com>
References: <87oa9ljolv.fsf@free-electrons.com>
Message-ID: <20160413214817.GY19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 10:49:32AM -0700, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for dt for mvebu for v4.7.
> 
> Gregory
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.7-1
> 
> for you to fetch changes up to 6280ed04f56d2bc651d1bcc97b1034161c04832c:
> 
>   ARM: kirkwood: DT: Add address go regulator unit name (2016-04-03 14:12:39 +0200)
> 
> ----------------------------------------------------------------
> mvebu dt for 4.6 (part 1)
> 
> - add hardware monitor support in the NSA320 device tree
> - update makefile with kirkwood-ds112.dtb and kirkwood-nsa320.dtb
> - fix GPIO config on the Linksys boards
> - various Kirkwood DT warning fixup from the newer DT compiler
> 
> ----------------------------------------------------------------
> Adam Baker (1):
>       ARM: dts: kirkwood: Add the hardware monitor to the NSA320 device tree
> 
> Andrew Lunn (8):
>       ARM: kirkwood: DT: Remove button address and fixup names
>       ARM: kirkwood: DT: Remove node address from leds
>       ARM: kirkwood: DT: Remove address from dsa unit name
>       ARM: kirkwood: DT: Add address to ethernet-phy unit name
>       ARM: kirkwood: DT: Fixup pcie DT warnings
>       ARM: kirkwood: DT: Remove address from gpio-i2c unit name
>       ARM: kirkwood: DT: Add address to mbus unit name
>       ARM: kirkwood: DT: Add address go regulator unit name

ARM: dts: kirkwood: ...

Please respin.


-Olof
