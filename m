From: khilman@ti.com (Kevin Hilman)
Date: Tue, 20 Mar 2012 10:46:57 -0700
Subject: [PATCH v4 RESEND 0/7] gpio/omap: Some more driver fixes
In-Reply-To: <20120320143544.AA6E93E2834@localhost> (Grant Likely's message of
 "Tue, 20 Mar 2012 14:35:44 +0000")
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
 <20120320143544.AA6E93E2834@localhost>
Message-ID: <87haxj17xq.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Grant Likely <grant.likely@secretlab.ca> writes:

> On Tue, 20 Mar 2012 16:23:12 +0530, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
>> This series excludes the cleanup patches as suggested by Kevin from
>> the previously posted series.
>> 
>> The fixes include correction of _set_gpio_irqenable() implementation,
>> missing wakeup_en register update in set_gpio_wakeup(), type mismatch
>> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
>> register update in set_gpio_dataout_() and few corrections in context
>> save logic.
>> 
>> It is baselined on top of:
>> git://git.secretlab.ca/git/linux-2.6.git gpio/next
>> Commit: 81b279d80a63628e580c71a31d30a8c3b3047ad4
>> 
>> Series is available here for reference:
>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_more_fixes
>
> Merged; thanks

Can you hold off slightly before merging this.

I haven't been through v4 yet or tested the fixes alone now that they're
separated from the other cleanups.

Expect a pull request from me when ready.

Thanks,

Kevin
