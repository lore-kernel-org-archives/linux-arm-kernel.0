From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 29 Dec 2016 09:44:59 -0500
Subject: [PATCH v5 09/14] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <586072E9.3060609@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-10-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0g4AoU-g4UWZFxLgQ_yfTC7KSBnZ_Ve945d+i58e=GuDQ@mail.gmail.com>
 <585E24FB.9050805@huawei.com>
 <CAJZ5v0itKF-uo7vGxK3+-X4OwBVYPdBw-b8v-8-CTBygpKMGoQ@mail.gmail.com>
 <586072E9.3060609@huawei.com>
Message-ID: <9aa650ad-a32d-e942-1c6b-b069c8a2b87a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/25/2016 8:31 PM, Hanjun Guo wrote:
>> A type->setup() would be somewhat cleaner I think, but then it's more
>> code.  Whichever works better I guess. :-)
> Agree, I will demo the type->setup() way and send out the patch for review,
> also I find one minor issue for the IORT code, will update that also for next
> version.

Can you provide details on what the minor issue is with the IORT code?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
