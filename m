From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Wed, 20 May 2015 06:51:34 -0500
Subject: [V4 PATCH 2/6] arm64 : Introduce support for ACPI _CCA object
In-Reply-To: <20150520100304.GE25313@e104818-lin.cambridge.arm.com>
References: <1431724994-21601-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1431724994-21601-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150520100304.GE25313@e104818-lin.cambridge.arm.com>
Message-ID: <555C7546.4040601@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/20/2015 5:03 AM, Catalin Marinas wrote:
> On Fri, May 15, 2015 at 04:23:10PM -0500, Suravee Suthikulpanit wrote:
>>  From http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf,
>> section 6.2.17 _CCA states that ARM platforms require ACPI _CCA
>> object to be specified for DMA-cabpable devices. This patch introduces
>> ACPI_MUST_HAVE_CCA in arm64 Kconfig to specify such requirement.
>>
>> In case _CCA is missing, arm64 would assign dummy_dma_ops
>> to disable DMA capability of the device.
>>
>> Signed-off-by: Mark Salter <msalter@redhat.com>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>

Thanks,

Suravee
