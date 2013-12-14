From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 14 Dec 2013 14:13:47 -0500
Subject: [PATCH v3 1/2] memory: ti-aemif: introduce AEMIF driver
In-Reply-To: <1386759570-29671-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1386759570-29671-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386759570-29671-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52ACADEB.30307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013 05:59 AM, Ivan Khoronzhuk wrote:
> Add new AEMIF driver for EMIF16 Texas Instruments controller.
> The EMIF16 module is intended to provide a glue-less interface to
> a variety of asynchronous memory devices like ASRA M, NOR and NAND
> memory. A total of 256M bytes of any of these memories can be
> accessed at any given time via 4 chip selects with 64M byte access
> per chip select.
> 
> Synchronous memories such as DDR1 SD RAM, SDR SDRAM and Mobile SDR
> are not supported.
> 
> This controller is used on SoCs like Davinci, Keysone2
> 
> Signed-off-by: [initial author] Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
