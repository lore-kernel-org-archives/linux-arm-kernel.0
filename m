From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 14 Aug 2015 09:12:28 -0500
Subject: [PATCH 1/3] Honor ACPI _CCA attribute setting
In-Reply-To: <55CD4832.7070301@amd.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
 <1439416290-21228-2-git-send-email-jeremy.linton@arm.com>
 <55CD4832.7070301@amd.com>
Message-ID: <55CDF74C.3050703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Suravee,

On 08/13/2015 08:45 PM, Suravee Suthikulpanit wrote:
> On 8/13/15 04:51, Jeremy Linton wrote:
>> ACPI configurations can now mark devices as noncoherent,
>> support that choice.
>
> This change was in my earlier revisions for the original patch series to
> add ACPI CCA support. At the time, this was pushed back since we were
> not sure whether this would be a useful case, and whether such hardware
> exists.

Yes, I was made aware of that conversation during the review here.

Basically, the ARM Juno development platform has a mix of coherent and 
noncoherent devices. The EHCI being one of the primary noncoherent 
peripherals. Without which, the usefulness of the platform for 
developing with an ACPI kernel is limited.


Thanks,
