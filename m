From: eric@anholt.net (Eric Anholt)
Date: Wed, 01 Jun 2016 15:30:35 -0700
Subject: [PATCH 09/32] bcm2837-rpi-3-b.dts for 32bit arm
In-Reply-To: <7065434.SNfT8zjcK3@wuerfel>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-10-git-send-email-kraxel@redhat.com>
 <7065434.SNfT8zjcK3@wuerfel>
Message-ID: <87zir4leyc.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday, June 1, 2016 11:43:18 PM CEST Gerd Hoffmann wrote:
>> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> new file mode 100644
>> index 0000000..36178a6
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> @@ -0,0 +1 @@
>> +#include "../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts"
>> -- 
>> 1.8.3.1
>> 
>
> What does this gain you?

Many Raspberry Pi users use a small set of SD cards that they swap
between various versions of the hardware.  It would be good to have
their 32-bit OS images work on the Pi3 as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160601/d63d9ec8/attachment.sig>
