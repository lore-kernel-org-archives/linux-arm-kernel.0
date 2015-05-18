From: tremyfr@gmail.com (Philippe Reynes)
Date: Mon, 18 May 2015 23:57:19 +0200
Subject: [PATCH 1/2] rtc: mxc: add a second clock
In-Reply-To: <5559CC85.5040703@melag.de>
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com>
 <1431729330-7625-2-git-send-email-tremyfr@gmail.com>
 <5559CC85.5040703@melag.de>
Message-ID: <555A603F.7000005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enrico,

On 18/05/15 13:27, Enrico Weigelt, metux IT consult wrote:
> Am 16.05.2015 um 00:35 schrieb Philippe Reynes:
>> The mxc RTC needs two clocks, one for the input
>> reference, and one for the IP. But this driver
>> was only using one clock (for the reference).
>> This patch add the second clock (for the IP).
>
>
> Does this also apply to MX53, or just MX21 ?

I don't found this rtc on mx53 manual. The mx53 seems to use rtc-imxdi.c.
So, I think it's just for mx21.

Regards,
Philippe
  
> greetings,
> --
> Enrico Weigelt, metux IT consult
> +49-151-27565287
> MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B
>
> Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
> Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.

  s
