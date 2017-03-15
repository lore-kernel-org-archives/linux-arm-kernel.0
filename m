From: j-keerthy@ti.com (Keerthy)
Date: Wed, 15 Mar 2017 07:55:49 +0530
Subject: [PATCH v3 00/25] arm/arm64: KVM: Rework the hyp-stub API
In-Reply-To: <CAGo_u6rHmn676_PZYj+6LGf-bRBBxdn1=PYX32o-_ki=OBXs-g@mail.gmail.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <8493dac7-c9be-fd3b-c5c0-83fbbfa4af10@ti.com>
 <8d2cf6fa-cac7-268b-bc26-2649f5696196@arm.com>
 <CAGo_u6rHmn676_PZYj+6LGf-bRBBxdn1=PYX32o-_ki=OBXs-g@mail.gmail.com>
Message-ID: <b9365064-d529-3957-f91c-da11d77f1abc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 14 March 2017 07:55 PM, Nishanth Menon wrote:
> On Tue, Mar 14, 2017 at 8:55 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> [...]
>>> Tested for kexec booting with the patch series applied on linux-next.
>>>
>>> kexec is working nicely with HYP and SVC modes. Tested for both modes by
>>> using different u-boot for booting in HYP and SVC modes. Kexec works well.
>>>
>>> Tested on DRA7-EVM, AM57XX-EVM and KEYSTONE-K2E-EVM.
>>>
>>> Tested-by: Keerthy <j-keerthy@ti.com>
>>
>> Thanks a lot. I assume this Tested-by applies to the 32bit patches in
>> this series?
> 
> Yes, the above platform list from Keerthy are all A15 32bit platforms.

Yes Marc. All are 32 bit platforms.

> 
> ---
> Regards,
> Nishanth Menon
> 
