From: khilman@ti.com (Kevin Hilman)
Date: Mon, 23 Apr 2012 17:34:30 -0700
Subject: [PATCH v2 3/4] ARM: OMAP2+: dmtimer: cleanup iclk usage
In-Reply-To: <CAC83ZvKrV6yjwj9BoU662p8MRbB-h2JGE6AS3eGgaPy8+z=J7w@mail.gmail.com>
 (Tarun Kanti DebBarma's message of "Tue, 24 Apr 2012 01:06:59 +0530")
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
 <1334925563-20768-4-git-send-email-tarun.kanti@ti.com>
 <87obqijq4j.fsf@ti.com>
 <CAC83ZvKrV6yjwj9BoU662p8MRbB-h2JGE6AS3eGgaPy8+z=J7w@mail.gmail.com>
Message-ID: <878vhmezmx.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Mon, Apr 23, 2012 at 11:18 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> We do not use iclk anywhere in the dmtimer driver and so removing it.
>>> Hence removing the timer iclk entries from OMAP4 clkdev table as well.
>>
>> What about the OMAP2/3 clkdev tables? ?Can't those be removed as well?
> No, they are being used. In fact I removed them in the beginning only
> to discover they are needed.

Maybe PATCH 0/x could summarize why they're still needed for OMAP2/3.

>>
>> Comment applies to PATCH 4/4 also.
> You mean removing iclk from clkdev table? That is already done in this patch!!

I meant why can't OMAP2/3 data be removed in PATCH 4/4 also, which only
touches OMAP4.

Kevin
