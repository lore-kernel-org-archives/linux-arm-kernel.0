From: David.Woodhouse@intel.com (David Woodhouse)
Date: Thu, 12 Aug 2010 12:23:51 +0100
Subject: [PATCH 1/2 v2] ARM: Fix gen_nand probe structures contents
In-Reply-To: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
References: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1281612232.12475.71.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-08-12 at 03:53 +0100, Marek Vasut wrote:
> These three platforms didn't properly fill nr_chips in gen_nand registration and
> therefore depended on gen_nand bug fixed by the following patch:
> 
> "mtd: gen_nand: fix support for multiple chips"
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> v2: Added other broken boards outside arch-arm (mips and bfin)
> v1: Initial patch
> 
>  arch/arm/mach-ixp4xx/ixdp425-setup.c      |    1 +
>  arch/arm/mach-mx3/mach-qong.c             |    1 +
>  arch/arm/mach-orion5x/ts78xx-setup.c      |    1 +
>  arch/blackfin/mach-bf537/boards/stamp.c   |    1 +
>  arch/blackfin/mach-bf561/boards/acvilon.c |    1 +
>  arch/mips/nxp/pnx833x/common/platform.c   |    1 +
>  6 files changed, 6 insertions(+), 0 deletions(-)

I'd already applied the three in arch/arm. Have now applied the others;
thanks.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
