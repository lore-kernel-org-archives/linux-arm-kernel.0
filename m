From: dhdang@apm.com (Duc Dang)
Date: Wed, 10 Feb 2016 09:58:32 -0800
Subject: [PATCH] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot
 for X-Gene v1
In-Reply-To: <56BB6EA0.7060706@arm.com>
References: <1455069384-22323-1-git-send-email-dhdang@apm.com>
 <56BB6EA0.7060706@arm.com>
Message-ID: <CADaLNDmsSvxSkvM8mG-TRYrmOMTFEKArsL0X=y1zb=20M27iaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 9:08 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 10/02/16 01:56, Duc Dang wrote:
>> This patch makes pci-xgene-msi driver ACPI-aware and provides
>> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>
> Another nail on the ACPI "standardization" coffin, I suppose... Oh well.
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks, Marc.

Regards,
Duc Dang.
>
>         M.
> --
> Jazz is not dead. It just smells funny...
