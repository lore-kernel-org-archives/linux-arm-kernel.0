From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Jul 2016 17:40:02 -0400
Subject: [PATCH 03/10] of: irq: make of_msi_configure accessible from
 modules
In-Reply-To: <CAL_Jsq+zLb0RcEdykDZXZpkgjjrDWa+-Bd0LTth3kB4H5X9pOQ@mail.gmail.com>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-4-git-send-email-okaya@codeaurora.org>
 <CAL_Jsq+zLb0RcEdykDZXZpkgjjrDWa+-Bd0LTth3kB4H5X9pOQ@mail.gmail.com>
Message-ID: <0fcc2c31-bd94-4a64-0456-9a35b692d2d8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/18/2016 5:24 PM, Rob Herring wrote:
> On Mon, Jul 18, 2016 at 1:39 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> The of_msi_configure routine is only accessible by the built-in
>> kernel drivers. Export this function so that modules can use it
>> too.
>>
>> This function is useful for configuring MSI on child device tree
>> nodes on hierarchical objects.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/of/irq.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks Rob

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
