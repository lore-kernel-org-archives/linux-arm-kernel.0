From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 1 Feb 2016 11:56:44 -0500
Subject: [PATCH V13 09/10] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56AF8CAB.3030908@codeaurora.org>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-10-git-send-email-okaya@codeaurora.org>
 <56AF82FA.7000303@linaro.org> <56AF84F4.2080809@codeaurora.org>
 <56AF87E2.8040201@linaro.org> <56AF8B6A.8040504@codeaurora.org>
 <56AF8CAB.3030908@codeaurora.org>
Message-ID: <56AF8E4C.10003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2016 11:49 AM, Timur Tabi wrote:
> Sinan Kaya wrote:
>> of-tested-by: ...
>>
>> Shanker and I tested ACPI before pushing the patches to the list and we also
>> posted the corresponding QEMU patches as well to the qemu-devel maillist.
>>
>> http://patchwork.ozlabs.org/patch/575878/
>>
>> I'll ask him to add his acpi-tested-by for the ACPI part.
> 
> I would rather not see a tested-by variant, and instead add comments to the line, like this:
> 
>     Tested-by: Eric Auger <eric.auger@linaro.org> (device tree only)
>     Tested-by: Shanker Donthineni <shankerd@codeaurora.org> (ACPI only)
> 
> That way, people can still grep for "^Tested-by:".
> 

will do.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
