From: pekon@pek-sem.com (pekon at pek-sem.com)
Date: Wed, 13 Aug 2014 21:14:14 +0530
Subject: [PATCH 0/8] mtd: nand: Support for new DT NAND driver
In-Reply-To: <1407921127-8590-1-git-send-email-lee.jones@linaro.org>
References: <1407921127-8590-1-git-send-email-lee.jones@linaro.org>
Message-ID: <a8fa82ea68d837e52306e6df62f2ed23@pek-sem.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On Wednesday 13 August 2014 02:41 PM, Lee Jones wrote:
> Hi Brian, Pekon,
>
> I believe all of your queries have either been answered or addressed
> and I am hoping this will be the last submission. :)
>
> /me crosses fingers!
>
> Kind regards,
> Lee
>
> Lee Jones (8):
>    ARM: multi-v7: Enable ST BCH NAND
>    ARM: sti: Add two new clock definitions for use with ST's NAND
>      controllers
>    ARM: sti: Add BCH (NAND Flash) Controller support for STiH41x 
> (Orly)
>      SoCs
>    ARM: sti: Enable BCH NAND for STiH416 B2020-RevE
>    mtd: nand: stm_nand_bch: provide Device Tree documentation
>    mtd: nand: add shared register defines for ST's NAND Controller
>      drivers
>    mtd: nand: stm_nand_bch: add support for ST's BCH NAND controller
>    mtd: nand: stm_nand_bch: provide ST's implementation of Back Block
>      Table
>

Couldn't review the last [Patch 8/8] for ST's BBT implementation as
I'm not familiar with it. But other patches look good. So for them

Reviewed-By: Pekon Gupta <pekon@pek-sem.com>


with regards, pekon


------------------------
Powered by BigRock.com
