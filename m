From: dhdang@apm.com (Duc Dang)
Date: Fri, 15 Apr 2016 14:30:56 -0700
Subject: [PATCH] pci: xgene: Add ECAM fixups
In-Reply-To: <2994764.UGKJE3zfLx@wuerfel>
References: <1455068984-22210-1-git-send-email-dhdang@apm.com>
 <2994764.UGKJE3zfLx@wuerfel>
Message-ID: <CADaLNDkCtUgFyX5tVgeM9grdHSQvpTHaq7qXk2WZ1tTbrP7OGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 6:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 February 2016 17:49:44 Duc Dang wrote:
>> X-Gene PCIe controller does not fully support ECAM.
>> This patch adds required ECAM fixup to allow X-Gene
>> PCIe controller to be functional in ACPI boot mode.
>>
>> This patch is based on the original work of
>> Mark Salter <msalter@redhat.com> and depends on
>> Tomasz's PCIe ACPI series:
>> https://lkml.org/lkml/2016/2/4/646
>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> ---
>
> This really has nothing to do with the PCI host device driver, please
> keep it in a separate file in drivers/acpi/.

Hi Arnd,

With Tomasz latest PCIe ACPI series
(https://lkml.org/lkml/2016/4/15/594), do you think it still better to
keep the ACPI ECAM fixup code in a separate file in drivers/acpi
directory?

Regards,
Duc Dang.

>
>         Arnd
