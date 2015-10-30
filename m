From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 30 Oct 2015 12:50:58 +0800
Subject: [PATCH V1 00/11] MMCONFIG refactoring and ARM64 PCI hostbridge
 init based on ACPI
In-Reply-To: <5632ED1C.7050500@redhat.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <5632ED1C.7050500@redhat.com>
Message-ID: <5632F732.3030805@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 2015/10/30 12:07, Jon Masters wrote:
> Hi Tomasz,
>
> Thanks for posting this series.
>
> On 10/27/2015 12:38 PM, Tomasz Nowicki wrote:
>
>> From the functionality point of view this series might be split into two logic parts:
>> 1. Making MMCONFIG code arch-agnostic which allows all architectures to collect
>>    PCI config regions and used when necessary.
>> 2. Using generic MMCONFIG code and introducing ACPI based PCI hostbridge
>>    initialization for ARM64
> Can I confirm that the intention here is that this replaces Hanjun's
> previous patch series? Here's the previous one we were tracking:
>
> https://lkml.kernel.org/g/1432644564-24746-1-git-send-email-hanjun.guo at linaro.org

Yes, that's the new version according to the discussion from my version.

>
> Assuming that is the case, then we will ping a number of folks to
> conduct testing and provide acks (this has already been discussed in a
> number of conversations with semiconductors over the past few days).

Much appreciated.

Thanks
Hanjun
