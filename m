From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 28 Feb 2011 15:57:43 +0200
Subject: [PATCH V5 6/6] pxa3xx_nand: clean the keep configure code
In-Reply-To: <1298860335-18638-7-git-send-email-leiwen@marvell.com>
References: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
	<1298860335-18638-7-git-send-email-leiwen@marvell.com>
Message-ID: <1298901463.2809.27.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 10:32 +0800, Lei Wen wrote:
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> ---
>  arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    2 +-
>  drivers/mtd/nand/pxa3xx_nand.c               |  103 +++++++++-----------------
>  2 files changed, 36 insertions(+), 69 deletions(-)

Similarly, could you please improve the commit message a bit?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
