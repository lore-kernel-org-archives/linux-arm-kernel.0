From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 18 Aug 2014 14:15:48 +0100
Subject: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
In-Reply-To: <2126088679.390471407886644188.JavaMail.weblogic@epmlwas02a>
 (=?utf-8?B?Iu2VqOuqheyjvCIncw==?= message of "Tue, 12 Aug 2014 23:37:25
 +0000 (GMT)")
References: <2126088679.390471407886644188.JavaMail.weblogic@epmlwas02a>
Message-ID: <9hhsikuey63.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

??? <myungjoo.ham@samsung.com> writes:

>> ------- Original Message -------
>> Sender : Hernandez, Carlos<ceh@ti.com>
>> Date : 2014-08-12 22:49 (GMT+09:00)
>> Title : RE: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
>> 
>> Acked-By: Carlos Hernandez 
>> 
>> -----Original Message-----
>> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-owner at vger.kernel.org] On Behalf Of Punit Agrawal
>> Sent: Friday, July 18, 2014 10:10 AM
>> To: linux-pm at vger.kernel.org; linux-samsung-soc at vger.kernel.org
>> Cc: orjan.eide at arm.com; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; MyungJoo Ham; Kyungmin Park
>> Subject: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
>> 
>> From: ?rjan Eide 
>> 
>> These functions are indended for use by drivers and should be available also when the driver is built as a module.> 
>> 
>> Cc: MyungJoo Ham 
>> Cc: Kyungmin Park 
>> Signed-off-by: ?rjan Eide 
>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>
> There will be some modifications to this patch for consistency with
> other pending patches, but please don't worry about them. I'll handle
> them while merging this.

Great! Thanks MyungJoo.

>
>
> Cheers,
> MyungJoo.
>
>> ---
>> drivers/devfreq/devfreq.c |    3 +++
>> 1 file changed, 3 insertions(+)
>
>
>
> --
> MyungJoo Ham (???), PHD
> Frontier CS Lab, Software Center
> Samsung Electronics
> Cell: +82-10-6714-2858--
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
