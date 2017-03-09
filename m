From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 9 Mar 2017 21:22:41 +0800
Subject: [PATCH v9 00/15] ACPI platform MSI support and its example mbigen
In-Reply-To: <20170307144334.GB26990@red-moon>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <20170307144334.GB26990@red-moon>
Message-ID: <67f52db7-c7b4-1c60-e844-28fd406d14d5@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2017/3/7 22:43, Lorenzo Pieralisi wrote:
> On Tue, Mar 07, 2017 at 08:39:55PM +0800, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> With platform msi support landed in the kernel, and the introduction
>> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
>> is ready, this patch set add few patches to enable the ACPI platform
>> msi support.
>>
>> For platform device connecting to ITS on arm platform, we have IORT
>> table with the named componant node to describe the mappings of paltform
>> device and ITS, so we can retrieve the dev id and find its parent
>> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
>>
>> v8 -> v9:
>> 	- Rebased on top of 4.11-rc1 and retest;
>> 	- Some of patch's commit message was updated by Lorenzo and
>> 	  it's clearer (thanks!)
>>
>> No update in the code, hope it's the final revision.
>
> I will be off the radar till -rc3 but I do not expect major changes
> to the series in its current form given that dependencies were merged
> in the merge window (ACPI IRQ probe deferral and IORT fixes).

What's your opinion on this patch set? especially for the last 3
patches for mbigen driver, please comment on it to see if I need
to take further steps.

Thanks
Hanjun
