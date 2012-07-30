From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 30 Jul 2012 22:01:04 +0800
Subject: [PATCH v3 0/9] Assorted PXA3xx DT patches
In-Reply-To: <201207291304.57063.arnd@arndb.de>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
 <201207291304.57063.arnd@arndb.de>
Message-ID: <CAN1soZw0sfLOp5beXEi7_v+MX0MbhDewBt_gC--7hHqLY3DFng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 29, 2012 at 9:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 28 July 2012, Daniel Mack wrote:
>>
>> This is a series of 9 patches that add basic support for booting PXA3xx
>> boards from devicetrees. I'm able to mount a rootfs and use all
>> irq/gpio based functions as well as the NAND, USB and RTC drivers.
>>
>> Changes from v2:
>>  - more "mrvl" -> "marvell" renaming fixes
>>  - avoid PXA_IRQ() in new code in arch/arm/mach-pxa/irq.c
>>  - add the two GPIO patches that have been acked-by Arnd already
>>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
Applied

Regards
Haojian
