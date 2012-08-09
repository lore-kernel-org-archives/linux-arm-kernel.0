From: khilman@ti.com (Kevin Hilman)
Date: Thu, 09 Aug 2012 14:25:39 -0700
Subject: [PATCH v2 1/2] cpufreq: OMAP: Handle missing frequency table on
 SMP systems
In-Reply-To: <201208092132.25141.rjw@sisk.pl> (Rafael J. Wysocki's message of
 "Thu, 9 Aug 2012 21:32:24 +0200")
References: <1344496102-24451-1-git-send-email-rnayak@ti.com>
 <201208091132.14992.rjw@sisk.pl> <87d330glel.fsf@ti.com>
 <201208092132.25141.rjw@sisk.pl>
Message-ID: <874nobhi5o.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday, August 09, 2012, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> > On Thursday, August 09, 2012, Rajendra Nayak wrote:
>> >> On OMAP4, if the first CPU fails to get a valid frequency table (this
>> >> could happen if the platform does not register any OPP table), the
>> >> subsequent CPU instances end up dealing with a NULL freq_table and
>> >> crash.
>> >> 
>> >> Check for an already existing freq_table, before trying to create one,
>> >> and increment the freq_table_users only if the table is sucessfully
>> >> created.
>> >> 
>> >> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >> Cc: <linux-pm@vger.kernel.org>
>> >
>> > Kevin, are you going to merge this?
>> >
>> 
>> Yes, I plan to queue this with 2/2 for v3.6-rc.
>
> If you have any cpufreq patches for v3.7, can you please tell me where to
> pull them from (and when)?

Yes, I will. 

Thanks,

Kevin
