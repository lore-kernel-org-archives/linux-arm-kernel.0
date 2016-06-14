From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 14 Jun 2016 15:37:11 -0500
Subject: [PATCH] ARM: socfpga: Update socfpga_defconfig
In-Reply-To: <1462480394-8084-1-git-send-email-marex@denx.de>
References: <1462480394-8084-1-git-send-email-marex@denx.de>
Message-ID: <alpine.DEB.2.02.1606141536130.4855@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 May 2016, Marek Vasut wrote:

> Enable the following bits:
> 
> CONFIG_TOUCHSCREEN_STMPE
>  - STMPE touchscreen support, needed on MCVEVK as it contains the
>    chip. This also enables the STMPE MFD device and touchscreen
>    input support.
> 
> CONFIG_USB_STORAGE
>  - USB storage support is often used, so enable it.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/configs/socfpga_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>

Sorry that this took me a while, I missed it somehow. Anywways, applied! 

Thanks,
Dinh
