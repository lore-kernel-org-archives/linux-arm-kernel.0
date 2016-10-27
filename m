From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 27 Oct 2016 12:24:48 +0200
Subject: [PATCH v6 00/16] ACPI IORT ARM SMMU support
In-Reply-To: <20161026110459.GA15276@red-moon>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
 <20161026110459.GA15276@red-moon>
Message-ID: <CAJZ5v0i=ZZDwnAU_=cAW5NR5M7EAOVPmpdqfMhf_jGmeZoHLVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 1:04 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Rafael, Joerg (and anyone else CC'ed),
>
> On Tue, Oct 18, 2016 at 05:03:58PM +0100, Lorenzo Pieralisi wrote:
>> This patch series is v6 of a previous posting:
>>
>> https://lkml.org/lkml/2016/9/9/418
>>
>> v5 -> v6
>>       - Rebased against v4.9-rc1
>>       - Changed FWNODE_IOMMU to FWNODE_ACPI_STATIC
>>       - Moved platform devices creation into IORT code
>>       - Updated fwnode handling
>>       - Added default dma masks initialization
>
> Any comments on v6 ? Patches touching generic ACPI code
> are {1, 2, 7}, patch 4 updates the IOMMU of_iommu_{set/get}_ops()
> API to make it work on ACPI systems too, by replacing the
> device_node with a fwnode_handle pointer as look-up token;
> the remainder of patches are ARM specific and creates the
> infrastructure to probe ARM SMMU devices through ACPI,
> ARM IORT table in particular. Given the generic bits changes
> above I would not leave it to late -rc to reach an agreement
> please, thank you.

I'll do my best to look at these in the next few days, but please also
note what I wrote before:

http://marc.info/?l=linux-acpi&m=147744344531599&w=2

Thanks,
Rafael
