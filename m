From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 17:36:03 +0200
Subject: [PATCH 1/1 linux-next RESEND] ARM: multi_v7_defconfig: update
 XILINX_VDMA
In-Reply-To: <1471282484-10810-1-git-send-email-fabf@skynet.be>
References: <1471282484-10810-1-git-send-email-fabf@skynet.be>
Message-ID: <6215142.AUZfTk6HDM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 15, 2016 7:34:44 PM CEST Fabian Frederick wrote:
> Commit fde57a7c4474
> ("dmaengine: xilinx: Rename driver and config")
> 
> renamed config XILINX_VDMA to config XILINX_DMA
> Update defconfig accordingly.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> Sending to arm-soc (suggested by Shawn Guo)
> 

You did not actually address this to arm at kernel.org, but I found
it and have now applied it to the fixes branch for v4.8.

Thanks!

	Arnd
