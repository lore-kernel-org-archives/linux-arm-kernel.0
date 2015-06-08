From: jteki@openedev.com (Jagan Teki)
Date: Mon, 8 Jun 2015 17:35:34 +0530
Subject: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
In-Reply-To: <556540C7.6080301@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1951882.p8DdrcurkC@vostro.rjw.lan> <556540C7.6080301@linaro.org>
Message-ID: <CAD6G_RQnm-y9eQdYGV89zzY-x90ESo6-APPVpY7eiJ=AJbg2rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 May 2015 at 09:27, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2015?05?27? 08:30, Rafael J. Wysocki wrote:
>>
>> On Tuesday, May 26, 2015 08:49:13 PM Hanjun Guo wrote:
>>>
>>> This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
>>> which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
>>> code into ACPI core":
>>>
>>> https://lkml.org/lkml/2015/5/14/98
>>
>>
>> I'll be regarding this patchset as an RFC until the one from Jiang Liu
>> goes in.
>
>
> Yes, please, Jiang Liu's patch set should go in first.

Apart from picking all, I have skipped x86, ia64 changes from above
and Jiang Liu's
series with disabling MSI, but I'm observing my arm64 board isn't
booted from uefi.

I'm suspecting pci-acpi changes were generic to specific pcie root
bridge controller,
but do I need to do any changes wrt pcie bridge? let me know if I miss
anything here.

thanks!
-- 
Jagan.
