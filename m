From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Fri, 01 Feb 2013 12:23:05 +0100
Subject: [PATCH] ARM: dts: AM33XX: Corrects typo in interrupt field in SPI
 node
In-Reply-To: <1359697047-1816-1-git-send-email-avinashphilip@ti.com> (Philip
 Avinash's message of "Fri, 1 Feb 2013 11:07:27 +0530")
References: <1359697047-1816-1-git-send-email-avinashphilip@ti.com>
Message-ID: <8738xg8ehy.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Philip" == Philip Avinash <avinashphilip@ti.com> writes:

 Philip> DT field of "interrupts" was mentioned wrongly as "interrupt" in SPI
 Philip> node. This went unnoticed as spi-omap2 driver not making use of
 Philip> interrupt. Fixes the typo.

 Philip> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
