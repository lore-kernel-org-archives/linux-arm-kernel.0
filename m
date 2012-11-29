From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 29 Nov 2012 21:04:06 +0100
Subject: [PATCH 2/4] rtc: pxa: fix rtc caculation issue
In-Reply-To: <1354155670-6267-2-git-send-email-chao.xie@marvell.com> (Chao
 Xie's message of "Wed, 28 Nov 2012 21:21:08 -0500")
References: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
 <1354155670-6267-2-git-send-email-chao.xie@marvell.com>
Message-ID: <87r4nc18i1.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chao Xie <chao.xie@marvell.com> writes:

Hi Chao Xie,

First of all, could you please send patches from rtc-pxa to me also, as I'm
maintaining that driver ?

Second point, the original design of the driver relies on the special case of
writing zeroes to WOM and DOM, as mentionned in PXA27x Developers Guide, chapter
21.4.2.3.5 "Writing Alarm Registers with Invalid (Zero) Data", which states :
> Day-Of-Week (DOW), or Week-Of-Month (WOM), Day of Month (DOM), Month or Year
> fields?Zero is not valid for these fields. If zero is written into any of
> these fields, it is ignored while generating the alarm.

I'd like to know if your patch fixes something, or is an enhancement ?

Cheers.

--
Robert

PS: I've not checked the patch yet, that's just a prelimary comment on the patch
message.
