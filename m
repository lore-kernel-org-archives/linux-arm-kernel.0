From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 13 Jun 2016 10:02:59 -0400
Subject: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors
 against platfrom specific ECAM quirks
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx>
Message-ID: <575EBD13.8080808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/13/2016 9:54 AM, Gabriele Paoloni wrote:
> As you can see here Liudongdong has replaced oem_revision with
> oem_table_id.
> 
> Now it seems that there are some platforms that have already shipped
> using a matching based on the oem_revision (right Jon?)
> 
> However I guess that if in FW they have defined oem_table_id properly
> they should be able to use this mechanism without needing to a FW update.
> 
> Can these vendors confirm this?
> 
> Tomasz do you think this can work for Cavium Thunder?
> 
> Thanks
> 
> Gab

Why not have all three of them? 

The initial approach was OEM id and revision id. 

Jeff Hugo indicated that addition (not removing any other fields) of table id
would make more sense.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
