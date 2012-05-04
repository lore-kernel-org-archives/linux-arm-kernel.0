From: b32955@freescale.com (Huang Shijie)
Date: Fri, 4 May 2012 12:30:43 +0800
Subject: [PATCH 1/2] mtd: gpmi: add device tree support to gpmi-nand
In-Reply-To: <4FA34EAD.1010302@grid-net.com>
References: <1336101182-5200-1-git-send-email-b32955@freescale.com>
 <4FA34EAD.1010302@grid-net.com>
Message-ID: <4FA35B73.8080008@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> Any chance you can add some information on what kind of mtd tests were 
> done with this code change and on what platform?
I did bonnie++ test, and mtd_speed test on mx28evk board.
>
> Also if one wanted to test this patch say on mx28 based hardware, one 
> should apply this patch against arm-soc tree, top of the 3.5-next tree?
If you only want to test this on mx28 based hardware, you can just apply 
this patch against the arm-soc tree, top of the 3.5-next tree.
But you still need some extra mxs-dma patches (and maybe do some 
hardcode for pinctl) to make the gpmi-nand driver work.

Best Regards
Huang Shijie
