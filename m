From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 23 Oct 2016 23:48:40 -0400
Subject: [PATCH V4 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
In-Reply-To: <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
 <20161021015814.GC31044@localhost> <20161021144535.GB877@localhost>
 <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
Message-ID: <6fb06d82-13aa-555b-72fc-06e670f9fd28@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 12:13 PM, Sinan Kaya wrote:
>> Wait a minute, I still have a question here: what about other ACPI
>> > arches (ia64, arm64)?  Don't they need to call acpi_penalize_sci_irq()
>> > somewhere?
>> > 
> ACPI ARM64 architecture implements reduced ACPI profile which doesn't
> have GED object.

I actually wanted to mean that ARM64 architecture doesn't have *GPE* object
implemented on ACPI reduced profile.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
