From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 21 Apr 2014 09:48:16 -0400
Subject: [PATCH 0/4] Introduce drivers/soc and add QCOM GSBI driver
In-Reply-To: <1398058244-14099-1-git-send-email-agross@codeaurora.org>
References: <1398058244-14099-1-git-send-email-agross@codeaurora.org>
Message-ID: <535521A0.5050706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 04/21/2014 01:30 AM, Andy Gross wrote:
> The first patch in this set adds the drivers/soc directory and all the necessary
> plumbing.  These changes were discussed at the kernel summit and also were
> introduced in an earlier patch set from Santosh Shilimkar.
> 
> Reference the following set of patches:
> https://lkml.org/lkml/2014/2/28/567

In that thread, Olof wrote, "The code [going into drivers/soc] isn't the pure
drivers. Those we find homes for."

https://lkml.org/lkml/2014/3/2/123

> The remaining patches add the QCOM GSBI (General Serial Bus Interface) driver,
> device tree binding information for both the GSBI and child node interaction,
> and lastly a patch to fix the current MSM serial driver to work correctly with
> the GSBI changes.

It's not obvious to me what makes the GSBI driver "impure" and unfit for say
drivers/bus. Could you perhaps include a brief explanation?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
