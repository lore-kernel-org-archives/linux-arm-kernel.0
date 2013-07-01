From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 01 Jul 2013 09:25:30 +0300
Subject: [PATCH 0/2] atmel_nand: remove cpu_is_xxx() in nand driver
In-Reply-To: <1368084895-18266-1-git-send-email-josh.wu@atmel.com>
References: <1368084895-18266-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1372659930.22014.15.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-05-09 at 15:34 +0800, Josh Wu wrote:
> avoid to use cpu_is_xxx() macro in driver, we use platform data and dts
> for the different cpu.
> 
> Josh Wu (2):
>   atmel_nand: at91/avr32/: Replace cpu_is_at32ap7000() with a nand
>     platform data
>   mtd: atmel_nand: add a new dt binding item for nand dma support

Pushed these 2 to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
