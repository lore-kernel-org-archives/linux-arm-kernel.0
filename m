From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 28 Jan 2017 01:02:24 +0800
Subject: [PATCH 3/3] MAINTAINERS: Update AT91 entries
In-Reply-To: <20170127170046.gy3mjsf3hwy5fpfq@piout.net>
References: <20170127162842.706-1-alexandre.belloni@free-electrons.com>
 <20170127162842.706-3-alexandre.belloni@free-electrons.com>
 <6ad97c20-07ed-0639-9fdb-968946ef943d@atmel.com>
 <A7BBC2CE-1428-421F-AA98-F2B0C0373B05@jcrosoft.com>
 <20170127170046.gy3mjsf3hwy5fpfq@piout.net>
Message-ID: <A2F6C26B-ABDA-4DAC-94A0-56E27052C2BF@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Jan 28, 2017, at 1:00 AM, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> On 28/01/2017 at 00:51:13 +0800, Jean-Christophe Plagniol-Villard wrote:
>> 	this does not mean I do not follow the ML
>> 
> 
> That's not what I'm implying. Many people are following various mailing
> list without being listed in MAINTAINERS.
So I?m still maintaining the drivers even there is not much to do today

so no

Best Regards,
J.
> 
>> Best Regards,
>> J.
>>> On Jan 28, 2017, at 12:32 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>>> 
>>> Le 27/01/2017 ? 17:28, Alexandre Belloni a ?crit :
>>>> Jean Christophe has not been active on the mailing lists for a while.
>>>> Remove him from the maintainers
>>>> 
>>>> Also, merge both AT91 pinctrl drivers entries.
>>>> 
>>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> 
>>> Yes:
>>> 
>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> 
>>> Thanks, regards,
>>> 
>>>> ---
>>>> Also, as pointed to by Tomi (https://lkml.org/lkml/2016/9/27/72), emails were
>>>> bouncing for a while
>>>> 
>>>> 
>>>> MAINTAINERS | 8 +-------
>>>> 1 file changed, 1 insertion(+), 7 deletions(-)
>>>> 
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index eb9739ec4e92..bfcc70032254 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1093,7 +1093,6 @@ F:	drivers/*/*aspeed*
>>>> ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
>>>> M:	Nicolas Ferre <nicolas.ferre@microchip.com>
>>>> M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>>> -M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>>> L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>> W:	http://www.linux4sam.org
>>>> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
>>>> @@ -9704,16 +9703,11 @@ F:	drivers/pinctrl/
>>>> F:	include/linux/pinctrl/
>>>> 
>>>> PIN CONTROLLER - ATMEL AT91
>>>> -M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>>> -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>> -S:	Maintained
>>>> -F:	drivers/pinctrl/pinctrl-at91.*
>> Nack
>>>> -
>>>> -PIN CONTROLLER - ATMEL AT91 PIO4
>>>> M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>>>> L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>> L:	linux-gpio at vger.kernel.org
>>>> S:	Supported
>>>> +F:	drivers/pinctrl/pinctrl-at91.*
>>>> F:	drivers/pinctrl/pinctrl-at91-pio4.*
>>>> 
>>>> PIN CONTROLLER - INTEL
>>>> 
>>> 
>>> -- 
>>> Nicolas Ferre
>>> 
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
