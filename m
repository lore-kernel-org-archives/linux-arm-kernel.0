From: b32955@freescale.com (Huang Shijie)
Date: Thu, 16 Feb 2012 09:56:10 +0800
Subject: [PATCH] mtd/gpmi : add gpmi support for mx6q
In-Reply-To: <20120215183720.GA2399@r65073-Latitude-D630>
References: <1328505606-27981-1-git-send-email-b32955@freescale.com>
 <20120215183720.GA2399@r65073-Latitude-D630>
Message-ID: <4F3C623A.3000301@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> The imx6q only supports DT boot, but I do not see you are adding DT
> probe for the driver, so I'm wondering how you tested the driver on
> imx6q.
>
This patch is just the first patch  for mx6q. My following patches will
add DT to the gpmi nand driver for mx6q. Due to the dependency issue, I 
will send the patches
in the following order:
[1] mtd/gpmi: add gpmi support for mx6q.
[2] [PATCH v5] patch set about the MXS-DMA
[3] add DT support to gpmi for mx6q.

I tested this patch based on our bsp code.

BR
Huang Shijie
