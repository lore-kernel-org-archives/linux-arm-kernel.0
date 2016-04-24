From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 23 Apr 2016 22:00:00 -0500
Subject: [PATCH v6 04/10] irqchip/gic-v2: Parse and export virtual GIC
 information
In-Reply-To: <1460388780-914-5-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-5-git-send-email-julien.grall@arm.com>
Message-ID: <571C36B0.9040003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2016 10:32 AM, Julien Grall wrote:
> For now, the firmware tables are parsed 2 times: once in the GIC
> drivers, the other timer when initializing the vGIC. It means code
> duplication and make more tedious to add the support for another
> firmware table (like ACPI).
>
> Introduce a new structure and set of helpers to get/set the virtual GIC
> information. Also fill up the structure for GICv2.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

Using the Qualcomm Technologies QDF2XXX server platform.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
