From: j.kilb@phytec.de (=?ISO-8859-1?Q?J=FCrgen_Kilb?=)
Date: Thu, 05 Jan 2012 09:08:49 +0100
Subject: updating machine registry for 2843/pcaal1
In-Reply-To: <20120104211536.GE11810@n2100.arm.linux.org.uk>
References: <4F032A10.9030203@phytec.de>
 <20120104211536.GE11810@n2100.arm.linux.org.uk>
Message-ID: <4F055A91.7040701@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.01.2012 22:15, Russell King - ARM Linux wrote:
> On Tue, Jan 03, 2012 at 05:17:20PM +0100, J?rgen Kilb wrote:
>> Hi Russell,
>>
>> I've tried to fix the machine name of our product in the machine
>> registry for machine number 2843.
>> The correct name is pcaal1. As you can see the machine name and the type
>> macro are correct now.
>>
>> Could you please update the Kconfig macro and the Type Identifier ?
>>
>> is:
>> machine_is_pcaal1()
>> CONFIG_MACH_PCA102
>> MACH_TYPE_PCA102
>>
>> should be:
>> machine_is_pcaal1()
>> CONFIG_MACH_PCAAL1
>> MACH_TYPE_PCAAL1
> Updated.
>
> Please confirm it's correct.  Thanks.
Yes, it's correct now. Thanks.

-J?rgen
