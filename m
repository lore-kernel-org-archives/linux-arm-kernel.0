From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 21 Jul 2014 18:35:25 +0100
Subject: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
In-Reply-To: <32148397.172891405898897186.JavaMail.weblogic@epml01>
 (=?utf-8?B?Iu2VqOuqheyjvCIncw==?= message of "Sun, 20 Jul 2014 23:28:17
 +0000 (GMT)")
References: <32148397.172891405898897186.JavaMail.weblogic@epml01>
Message-ID: <9hh8unmr4wy.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

??? <myungjoo.ham@samsung.com> writes:

> Sender : Punit Agrawal<punit.agrawal@arm.com>
>> From: ?rjan Eide 
>>
>> These functions are indended for use by drivers and should be available
>> also when the driver is built as a module.
>>
>> Cc: MyungJoo Ham 
>> Cc: Kyungmin Park 
>> Signed-off-by: ?rjan Eide 
>
> Dear Punit,

Hi MyungJoo,

>
>
> Just being curious, is there any reason not to use EXPORT_SYMBOL_GPL ?

No reason other than to match the existing EXPORT_SYMBOLs in this file.

Would you prefer this and the following patch to use EXPORT_SYMBOL_GPL
instead?

>
>
> Cheers,
> MyungJoo.
>
> --
> MyungJoo Ham (???), PHD
> Frontier CS Lab, Software Center
> Samsung Electronics
> Cell: +82-10-6714-2858--
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
