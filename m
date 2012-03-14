From: b32955@freescale.com (Huang Shijie)
Date: Wed, 14 Mar 2012 16:43:21 +0800
Subject: [PATCH v1 5/5] ARM: mxs: add mxs dma dt support
In-Reply-To: <20120314083046.GD1180@shlinux2.ap.freescale.net>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-6-git-send-email-b29396@freescale.com>
 <4F604F9F.1070801@freescale.com>
 <20120314083046.GD1180@shlinux2.ap.freescale.net>
Message-ID: <4F605A29.6080009@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aisheng:
> The non-dt way also does not have interrupt resource for dma device.
> It seems the channel interrupt resource is handled in each client device.
> I'm not familiar with gpmi-nand, but I guess you may need to handle
> it in gpmi driver, just like mxs-mmc driver.
>
ok, got it.

thanks
Huang Shijie
