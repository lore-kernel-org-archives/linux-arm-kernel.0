From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Mon, 19 Dec 2011 17:29:49 +0000
Subject: Status of the following patch (clocksource sched_clock) ?
In-Reply-To: <20111219172557.GH14542@n2100.arm.linux.org.uk>
References: <3E54258959B69E4282D79E01AB1F32B7249324@DFLE34.ent.ti.com>
 <20111219172557.GH14542@n2100.arm.linux.org.uk>
Message-ID: <3E54258959B69E4282D79E01AB1F32B724934E@DFLE34.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Thanks for responding.

>> 
>> > Could someone tell me what is the status of this patch? I want to try
>> > it on my target platform which is a davinci variant.
>> 
>> Dead.
>> 
>> Just make sure you use the sched_clock infrastructure already provided
>> on ARM and provided you give it the correct information - and set it up
>> early enough (in init_early) you will not have any sched_clock() wraps.
>> This is because a timer will be set to automatically update things
>> before any wrap occurs.

Good to know that there is already support available to avoid clocksource wraparound. Could you point me to the code in kernel tree where this infrastructure is located and some sample code that implements it?

Thanks

Murali
