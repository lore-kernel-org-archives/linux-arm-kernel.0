From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 08 May 2014 19:19:38 +0200
Subject: [PATCH] ARM: at91: fix rtc irq mask for sam9x5 SoCs
In-Reply-To: <CAJjB1q+sZvJ=VDFsZJyvqSiOa=zapmnzkAvY1pW2KwjZK4uaKg@mail.gmail.com>
References: <957b209589094df48ddedbc57c6ccdfd@BLUPR05MB037.namprd05.prod.outlook.com>
 <1399479649-3247-1-git-send-email-boris.brezillon@free-electrons.com>
 <edaf5835a7b14b9a8c053dcd40f2b591@BLUPR05MB037.namprd05.prod.outlook.com>
 <CAJjB1q+sZvJ=VDFsZJyvqSiOa=zapmnzkAvY1pW2KwjZK4uaKg@mail.gmail.com>
Message-ID: <536BBCAA.6020309@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/05/2014 05:10, Mark Roszko wrote:
> Atmel actually has this issue in the Errata of the SAM9G25 and SAM9G35
> datasheets which might be worth referencing in the description?
>
>> 49.7.1 RTC: Interrupt Mask Register cannot be used
>> Interrupt Mask Register read always returns 0.

Sure, I'll quote atmel's datasheet and state that it only impacts
sam9g25 and g35 SoCs.

Thanks,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
