From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 22 Mar 2011 17:57:00 +0530
Subject: [PATCH v17 13/13] davinci: dm644x EVM: add support for VPBE
	display
In-Reply-To: <1300197595-5188-1-git-send-email-manjunath.hadli@ti.com>
References: <1300197595-5188-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C47D7C2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2011 at 19:29:55, Hadli, Manjunath wrote:
> This patch adds support for V4L2 video display to DM6446 EVM.
> Support for SD and ED modes is provided, along with Composite
> and Component outputs.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> ---
>  arch/arm/mach-davinci/board-dm644x-evm.c    |  108 ++++++++++++++++++++++++++-
>  arch/arm/mach-davinci/dm644x.c              |    4 +-
>  arch/arm/mach-davinci/include/mach/dm644x.h |    3 +-

The changes adding the SoC support should be folded
into patch 12/13.

Thanks,
Sekhar
