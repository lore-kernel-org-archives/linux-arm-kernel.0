From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 06 May 2010 15:11:47 +0200
Subject: arm926_dma_flush_range undefined!
Message-ID: <4BE2C013.4040009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I am trying to compile a recent kernel 
(v2.6.34-rc6-201-g722154e) and I am 
having this kind of error:

ERROR: "arm926_dma_flush_range" [drivers/mmc/host/at91_mci.ko] undefined!

As the arm926_dma_flush_range assembler 
function seems to exits in the kernel, I 
have difficulties to figure out what the 
issue comes from...
As I am maintainer of this driver, I would 
like to fix this very fast ;-)

This error shows up while I compile this 
driver as a module.

Do you have any hint?

Thanks, best regards,
-- 
Nicolas Ferre
