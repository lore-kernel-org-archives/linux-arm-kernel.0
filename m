From: b32955@freescale.com (Huang Shijie)
Date: Tue, 3 Dec 2013 18:36:50 +0800
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <201312030132.10410.marex@denx.de>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
 <201312030132.10410.marex@denx.de>
Message-ID: <529DB442.90206@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?12?03? 08:32, Marek Vasut ??:
> Finally, the erase_sector() call would probably need to be extended. I would
> rename it to simple erase(), since we can erase from sub-sectors (4K) to whole
> chip.
yes. this is what i am coding now. I rename it to erase().

thanks
Huang Shijie
