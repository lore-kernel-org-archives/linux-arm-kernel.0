From: davidb@codeaurora.org (David Brown)
Date: Fri, 29 Apr 2011 13:27:16 -0700
Subject: [PATCH 00/10] ARM: SMP initialization consolidation
In-Reply-To: <4DBB027F.2010405@gmail.com> (Rob Herring's message of "Fri, 29
	Apr 2011 13:25:03 -0500")
References: <1303940515-8807-1-git-send-email-robherring2@gmail.com>
	<4DBB027F.2010405@gmail.com>
Message-ID: <8yavcxwrefv.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29 2011, Rob Herring wrote:

> On 04/27/2011 04:41 PM, Rob Herring wrote:
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> In order to avoid duplicating the same platform code yet again for a new
>> platform, this series consolidates platforms using similar SMP startup code to
>> a common implementation. A new kconfig entry SMP_COMMON_PEN is added for
>> platforms using the common pen functions.
>>
>>
>
> Comments?
>
> I only have a Versatile Express to test on, so any Tested-by's would
> be appreciated.

I don't seem to be able to find the actual patch messages themselves,
only this message.  Do you have a reference on an archive somewhere?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
