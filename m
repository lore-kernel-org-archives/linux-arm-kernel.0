From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 6 Mar 2014 23:27:02 -0800
Subject: [PATCH 0/3] mtd: gpmi: add subpage read support
In-Reply-To: <1388718102-26097-1-git-send-email-b32955@freescale.com>
References: <a>
 <1388718102-26097-1-git-send-email-b32955@freescale.com>
Message-ID: <20140307072702.GC13420@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 11:01:39AM +0800, Huang Shijie wrote:
>  5) This patch depends on the following patch:
>     http://lists.infradead.org/pipermail/linux-mtd/2013-December/051091.html

Do you have an actual dependency? I don't spot it myself. They applied
fine to my tree, and the code is logically independent.

I'm ready to push this series (but not the linked one quite yet; let me
have a look). Shout if this is incorrect.

> Huang Shijie (3):
>   mtd: nand: add "page" argument for read_subpage hook
>   mtd: gpmi: do not use the mtd->writesize
>   mtd: gpmi: add subpage read support

Thanks,
Brian
