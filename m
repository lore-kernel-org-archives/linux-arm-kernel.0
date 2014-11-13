From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Thu, 13 Nov 2014 12:40:40 +0200
Subject: [PATCH v7 00/12] NVIDIA Tegra memory controller and IOMMU support
In-Reply-To: <1550140.Lb4KHPOqX1@wuerfel>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
 <1550140.Lb4KHPOqX1@wuerfel>
Message-ID: <54648AA8.2020509@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2014 12:12 PM, Arnd Bergmann wrote:
> On Thursday 13 November 2014 10:32:25 Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> This is the sixth installment in the Tegra IOMMU and memory controller
>> support series. This version addresses the final outstanding comments from
>> Olof about using proper Kconfig symbols to track the dependencies. It also
>> splits up the driver into one part that implements the memory controller
>> only and a second part that implements the SMMU. This plays nicely with
>> the new Kconfig options introduced.
>>
>> Patch 1 is a preparatory patch that exposes the memory controller clock.
>>
>> Patches 2 and 3 is a pair of precursory patches needed to make this all
>> work on 64-bit ARM in the future.
>>
>> The device tree binding for the Tegra memory controller is added in patch
>> 4 and patch 5 is the bulk of the series that move the existing memory
>> controller and IOMMU drivers into the new unified driver that supports
>> Tegra30, Tegra114 and Tegra124.
>
> I just noticed that patch 5 has never made it into my inbox in any of the
> submissions. Did it get filtered by the mailing list?

I have received patch 5 just fine through linux-tegra. The patch is 
rather long though, so something filtering it wouldn't be that surprising.

>
> 	Arnd

Mikko
