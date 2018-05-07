From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 7 May 2018 10:07:32 +0200
Subject: [PATCH 2/2] ARM: dts: imx28-duckbill-2-enocean: Remove
 unnecessary #address/#size-cells
In-Reply-To: <1525655020-31260-2-git-send-email-festevam@gmail.com>
References: <1525655020-31260-1-git-send-email-festevam@gmail.com>
 <1525655020-31260-2-git-send-email-festevam@gmail.com>
Message-ID: <46f2daad-1828-b4d8-5ff8-4aeb51b3ec0c@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.05.2018 um 03:03 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Remove unnecessary #address-cells/#size-cells to fix the following
> DTC warnings:
>
> arch/arm/boot/dts/imx28-duckbill-2-enocean.dtb: Warning (avoid_unnecessary_addr_size): /gpio-keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" propert
>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
Stefan
