From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 21 Jun 2014 16:57:11 +0800
Subject: [PATCH v3] ARM: dts: imx6: add aristainetos board support
In-Reply-To: <1403275967-22317-1-git-send-email-hs@denx.de>
References: <1403275967-22317-1-git-send-email-hs@denx.de>
Message-ID: <20140621085710.GA18165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 04:52:47PM +0200, Heiko Schocher wrote:
> This patch add support for the imx6dl based aristainetos board
> with following configuration:
> 
> CPU:   Freescale i.MX6DL rev1.1 at 792 MHz
> DRAM:  1 GiB
> NAND:  512 MiB
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> SF: Detected N25Q128 with page size 256 Bytes, erase size 64 KiB, total 16 MiB
> 
> As this board can used with 2 different display types, the
> differences between them are extracted into 2 DTS files, and
> the common settings are collected in a common file.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>

Applied, thanks.
