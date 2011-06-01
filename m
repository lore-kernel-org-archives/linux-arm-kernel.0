From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 01 Jun 2011 14:43:43 +0300
Subject: [PATCH 0/8] clean-up NAND / BBT code, flags
In-Reply-To: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
References: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1306928623.4405.108.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-31 at 16:31 -0700, Brian Norris wrote:
> Hello,
> 
> This patch series handles several issues with NAND chip flags and BBT
> flags, especially those related to the nand_chip.options and
> nand_bbt_descr.options fields. This topic was discussed and reviewed a
> bit on the linux-mtd thread found here:
>     http://lists.infradead.org/pipermail/linux-mtd/2011-April/035146.html
> 
> These changes have affected many drivers in relatively small ways, so
> I copied all the maintainers/contributors given by the
> scripts/getmaintainer.pl scripts. FYI, this patch set is based on the
> mtd-2.6.git repository from linux-mtd.
> 
> Also, the first patch:
>     mtd: nand: remove NAND_BBT_SCANBYTE1AND6 option
> solves the regression issues discussed here:
>     http://lists.infradead.org/pipermail/linux-mtd/2011-May/035696.html

Looks good to me, thank you. Pushed to l2-mtd-2.6.git.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
