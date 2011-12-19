From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Mon, 19 Dec 2011 17:37:44 +0000
Subject: Status of the following patch (clocksource sched_clock) ?
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B724934E@DFLE34.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B7249324@DFLE34.ent.ti.com>
 <20111219172557.GH14542@n2100.arm.linux.org.uk>
 <3E54258959B69E4282D79E01AB1F32B724934E@DFLE34.ent.ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7249373@DFLE34.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Is it init_sched_clock(),update_sched_clock() APIs that you are referring to?

Murali Karicheri
Software Design Engineer
email: m-karicheri2 at ti.com


>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Karicheri, Muralidharan
>> Sent: Monday, December 19, 2011 12:30 PM
>> To: Russell King - ARM Linux
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: RE: Status of the following patch (clocksource sched_clock) ?
>> 
>> Russell,
>> 
>> Thanks for responding.
>> 
>> >>
>> >> > Could someone tell me what is the status of this patch? I want to try
>> >> > it on my target platform which is a davinci variant.
>> >>
>> >> Dead.
>> >>
>> >> Just make sure you use the sched_clock infrastructure already provided
>> >> on ARM and provided you give it the correct information - and set it up
>> >> early enough (in init_early) you will not have any sched_clock() wraps.
>> >> This is because a timer will be set to automatically update things
>> >> before any wrap occurs.
>> 
>> Good to know that there is already support available to avoid clocksource
>> wraparound. Could you point me to the code in kernel tree where this
>> infrastructure is located and some sample code that implements it?
>> 
>> Thanks
>> 
>> Murali
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
