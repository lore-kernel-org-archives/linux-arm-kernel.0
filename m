From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Oct 2013 13:20:13 -0700
Subject: [PATCH v3 10/10] rtc: pm8xxx: add support for pm8941
In-Reply-To: <20131029201545.GA2064@kroah.com>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <1392ea90487793f9cbbdfb7f8d148f45122a52c2.1382985169.git.joshc@codeaurora.org>
 <20131029200927.GG21983@codeaurora.org> <20131029201545.GA2064@kroah.com>
Message-ID: <5270187D.3090004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/13 13:15, Greg Kroah-Hartman wrote:
> On Tue, Oct 29, 2013 at 01:09:27PM -0700, Stephen Boyd wrote:
>> On 10/28, Josh Cartwright wrote:
>>> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
>>> index 03f8f75..a9044d4 100644
>>> --- a/drivers/rtc/rtc-pm8xxx.c
>>> +++ b/drivers/rtc/rtc-pm8xxx.c
>>> @@ -1,4 +1,5 @@
>>>  /* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
>>> + * Copyright (c) 2013, The Linux Foundation. All rights reserved.
>>>   *
>> Please rewrite this as '2010-2011,2013, The Linux Foundation'
> Has the Linux Foundation really taken on all prior copyrights of this
> codebase?  CAF wasn't around in 2010 as part of the LF, so be careful
> here.
>

>From what I recall our lawyers told us to do this and there is some
precedence for this upstream as well.

commit e1858b2a21cd84a855945a4747fb2db41b250c22
Author: Richard Kuo <rkuo@codeaurora.org>
Date:   Wed Sep 19 16:22:02 2012 -0500

    Hexagon: Copyright marking changes
   
    Code Aurora Forum (CAF) is becoming a part of Linux Foundation Labs.
   
    Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
