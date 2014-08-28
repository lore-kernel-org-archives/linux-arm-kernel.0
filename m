From: suravee.suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Thu, 28 Aug 2014 04:15:17 -0500
Subject: [PATCH 1/2 V4] irqchip: gic: Add supports for ARM GICv2m MSI(-X)
In-Reply-To: <003d01cfb76b$629b43c0$27d1cb40$%han@samsung.com>
References: <1407942041-3291-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1407942041-3291-2-git-send-email-suravee.suthikulpanit@amd.com>
 <003d01cfb76b$629b43c0$27d1cb40$%han@samsung.com>
Message-ID: <53FEF325.20505@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/13/2014 09:56 PM, Jingoo Han wrote:
> On Thursday, August 14, 2014 12:01 AM, Suravee Suthikulpanit wrote:
>>
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> ARM GICv2m specification extends GICv2 to support MSI(-X) with
>> a new set of register frame. This patch introduces support for
>> the non-secure GICv2m register frame. Currently, GICV2m is available
>> in certain version of GIC-400.
>>
>> The patch introduces a new property in ARM gic binding, the v2m subnode.
>> It is optional.
>
> Hi Suravee Suthikulpanit,
>
> I added some minor comments.

Thanks for the cleaning up comments.

Suravee
