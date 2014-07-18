From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Fri, 18 Jul 2014 13:49:54 +0300
Subject: [PATCH v5 7/8] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <53C8F65C.2020800@redhat.com>
References: <1405500863-19696-8-git-send-email-mperttunen@nvidia.com>
 <1405667550-7707-1-git-send-email-mperttunen@nvidia.com>
 <53C8F65C.2020800@redhat.com>
Message-ID: <53C8FBD2.9@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks!

- Mikko

On 18/07/14 13:26, Hans de Goede wrote:
> Hi,
>
> On 07/18/2014 09:12 AM, Mikko Perttunen wrote:
>> This adds support for the integrated AHCI-compliant Serial ATA
>> controller present on the NVIDIA Tegra124 system-on-chip.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>> v5: let ahci_platform handle sata clock and also handle it ourselves.
>>    this allows use of ahci_platform while having a special sequence
>>    for the clock.
>
> Thanks, I like this one, much better then what we had before.
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
>
 >> ...
