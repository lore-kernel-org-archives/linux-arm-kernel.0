From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 6 Feb 2017 20:44:10 +0100
Subject: [PATCH 0/3] mtd: nand: sunxi: Perfs improvements
In-Reply-To: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170206204410.316ce645@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  6 Jan 2017 10:42:04 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> These 3 patches aims at improving the sunxi NAND driver perfs and
> avoiding busy waits on long operations to improve system reactivity.

Applied.

> 
> Regards,
> 
> Boris
> 
> Boris Brezillon (3):
>   mtd: nand: sunxi: Fix the non-polling case in sunxi_nfc_wait_events()
>   mtd: nand: sunxi: Stop using polling mode when waiting for long
>     operations
>   mtd: nand: sunxi: Improve sunxi_nfc_cmd_ctrl()
> 
>  drivers/mtd/nand/sunxi_nand.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
