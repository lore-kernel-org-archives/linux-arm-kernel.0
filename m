From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 10 Apr 2013 14:21:18 -0400
Subject: [PATCH v2 0/3] Add DT board setup for LaCie CloudBox
In-Reply-To: <1365460889-22965-1-git-send-email-simon.guinot@sequanux.org>
References: <1365460889-22965-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130410182118.GE28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 12:41:26AM +0200, Simon Guinot wrote:
> This patch series adds DT board setup for the LaCie CloudBox machine.
> Note that two patches have been added for this v2. The first,
> "ARM: Kirkwood: sort board entries by ASCII-code order" helps to respect
> alphabetical order while adding a new board entry. The last,
> "ARM: Kirkwood: update Network Space Mini v2 description" could be
> useful to differentiate the cloudbox and netspace_v2_mini machines
> (both embedded in products named LaCie CloudBox).
> 
> Regards,
> 
> Simon
> 
> Changes for v2:
>  - Add patch "ARM: Kirkwood: sort board entries by ASCII-code order".
>  - Add patch "ARM: Kirkwood: update Network Space Mini v2 description".
>  - Rebase against Jason's branch marvell/mvebu/boards.
>  - Remove i2c pinctrl declaration (not used).
>  - For all modified files, respect alphabetical order while inserting cloudbox
>    entries.
>  - Enhance patch description to avoid confusion between the two LaCie
>    products named CloudBox.
> 
> Simon Guinot (3):
>   ARM: Kirkwood: sort board entries by ASCII-code order
>   ARM: Kirkwood: DT board setup for CloudBox
>   ARM: Kirkwood: update Network Space Mini v2 description
> 
>  arch/arm/boot/dts/Makefile              |    3 +-
>  arch/arm/boot/dts/kirkwood-cloudbox.dts |   89 +++++++++
>  arch/arm/boot/dts/kirkwood-ns2mini.dts  |    1 +
>  arch/arm/configs/kirkwood_defconfig     |   51 ++---
>  arch/arm/mach-kirkwood/Kconfig          |  325 ++++++++++++++++---------------
>  arch/arm/mach-kirkwood/Makefile         |   41 ++--
>  arch/arm/mach-kirkwood/board-dt.c       |   14 +-
>  arch/arm/mach-kirkwood/board-ns2.c      |    3 +-
>  arch/arm/mach-kirkwood/common.h         |    6 +
>  9 files changed, 324 insertions(+), 209 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-cloudbox.dts

Whole series applied to mvebu/boards

thx,

Jason.
