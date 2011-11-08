From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 08 Nov 2011 11:56:57 +0100
Subject: [PATCH] at91: vmalloc fix missing AT91_VIRT_BASE define
In-Reply-To: <20111104180133.GC12913@n2100.arm.linux.org.uk>
References: <1320334246-16457-1-git-send-email-plagnioj@jcrosoft.com>
 <20111104180133.GC12913@n2100.arm.linux.org.uk>
Message-ID: <4EB90AF9.8010900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2011 07:01 PM, Russell King - ARM Linux :
> On Thu, Nov 03, 2011 at 11:30:46PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> break during the this merge
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Not the only bug:
> 
>   CC      drivers/tty/serial/atmel_serial.o
> drivers/tty/serial/atmel_serial.c: In function ?atmel_serial_probe?:
> drivers/tty/serial/atmel_serial.c:1788: error: implicit declaration of function ?of_alias_get_id?
> make[4]: *** [drivers/tty/serial/atmel_serial.o] Error 1
> make[3]: *** [drivers/tty/serial] Error 2
> make[2]: *** [drivers/tty] Error 2
> make[1]: *** [drivers] Error 2

Yes but it is already addressed in ed5f886d163 in Linus' tree.

Best regards,
-- 
Nicolas Ferre
