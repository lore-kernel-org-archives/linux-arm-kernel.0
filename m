From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Aug 2015 11:11:28 +0200
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.3 #2
In-Reply-To: <55BB3FAE.1020907@free-electrons.com>
References: <55BB3FAE.1020907@free-electrons.com>
Message-ID: <20150805091128.GL6390@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Fri, Jul 31, 2015 at 11:28:14AM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the second pull request for cleanup for mvebu for v4.3
> 
> Gregory
> 
> The following changes since commit 7e5308be4c0747e328d03f3daa46aaa5eaf7714f:
> 
>   ARM: mvebu: update EEPROM description of Armada 388 GP (2015-07-09 15:28:08 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.3-2
> 
> for you to fetch changes up to dc57844a736f10bf3799d63d7c0d0efc29b1ad7d:
> 
>   ARM: dts: orion5x: add buffalo linkstation ls-wtgl (2015-07-25 16:19:20 +0200)

Merged, thanks.


One tip:

> 
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 273 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 274 insertions(+)
>  create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts

If you redirect "git request-pull" to a file (or even pipe it through cat
instead of straight onto your terminal) it'll default to ~78 character lines
instead of the width of your terminal.


-Olof
