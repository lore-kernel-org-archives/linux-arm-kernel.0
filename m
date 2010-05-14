From: svenkatr@ti.com (Venkatraman S)
Date: Sat, 15 May 2010 00:13:06 +0530
Subject: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
In-Reply-To: <4BE8056C.6080106@ti.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5387482@dbde02.ent.ti.com>
	<004501caed38$03e7b9f0$544ff780@am.dhcp.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C538792A@dbde02.ent.ti.com>
	<000601caee06$b2c8a9b0$544ff780@am.dhcp.ti.com>
	<4BE4694F.3060901@ti.com>
	<x2r618f0c911005090351meff49918t941a904edb8027c3@mail.gmail.com>
	<4BE6DD8D.6030201@gmail.com>
	<i2h618f0c911005100531y94ddfd07l707946d460f357af@mail.gmail.com>
	<4BE8056C.6080106@ti.com>
Message-ID: <AANLkTin4dO7az90uo3LPJeVnTOvNLPJmKddUAXfdEiCx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> wrote:
> On 05/10/2010 07:31 AM, Venkatraman S wrote:
>>
>> Nishanth Menon<menon.nishanth@gmail.com> ?wrote:
>
>>>>> Please see [1] for SOC specific feature handling. any reasons we can't
>>>>> handle it by adding a new feature?
>>>>>
>>>>> [1]
>>>>>
>>>>>
>>>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/cpu.h#l439
>>>>>
>>>>
>>>> Thanks. I can add a new feature here, but I see that the API is tied
>>>> to OMAP3, whereas the DMA feature is common
>>>> to 3630, OMAP4 and mostly everything after that. I can work on an
>>>> upgrade, but do you see that
>>>> as a dependency and done on the context of this patch ?
>>>> Regards,
>>>> Venkat.
>>>
>>> Yes, I am aware that the current APIs are tied to OMAP3, no reason that
>>> we
>>> cant introduce a OMAP version independent feature.. Yes, IMHO, this is an
>>> SOC specific feature that has no place in a platform data.. lets not
>>> misuse
>>> that.
>>> Regards,
>>> NM
>>

Just a note that I have updated my patch series based on all the
comments except that the 'features' framework has to be created to be
utilised by this patch series. That would be a separate patch, which I
am working on, and will post on monday.
Regards,
Venkat.
