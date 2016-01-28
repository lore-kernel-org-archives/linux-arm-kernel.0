From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 18:00:46 +0100
Subject: [PATCH 1/2] ARM: shmobile: Move shmobile_scu_base from .text to
 .data
In-Reply-To: <56AA35AF.8080601@cogentembedded.com>
References: <1453993462-12210-1-git-send-email-geert+renesas@glider.be>
 <1453993462-12210-2-git-send-email-geert+renesas@glider.be>
 <56AA35AF.8080601@cogentembedded.com>
Message-ID: <CAMuHMdXNGMR+zUaYjp1AO8Yw5gsUAgnL8_U1XZj-y_9eD1+X7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 4:37 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> diff --git a/arch/arm/mach-shmobile/platsmp-scu.c
>> b/arch/arm/mach-shmobile/platsmp-scu.c
>> index 64663110ab6ca0e1..f2198c9c74359736 100644
>> --- a/arch/arm/mach-shmobile/platsmp-scu.c
>> +++ b/arch/arm/mach-shmobile/platsmp-scu.c
>> @@ -17,6 +17,9 @@
>>   #include <asm/smp_scu.h>
>>   #include "common.h"
>>
>> +
>
>    Why add 2nd empty line?

I always leave two blank lines between different sections, and one blank
line between function or data blocks.

Is that a problem?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
