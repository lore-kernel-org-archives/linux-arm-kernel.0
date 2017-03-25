From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 25 Mar 2017 10:03:33 -0400
Subject: [PATCH] ACPI / IPMI: allow ACPI_IPMI with IPMI_SSIF
In-Reply-To: <78897278-9240-6794-e99b-f3ff3013304f@acm.org>
References: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
 <78897278-9240-6794-e99b-f3ff3013304f@acm.org>
Message-ID: <2b8eeebf-9ea0-70f7-8f34-d6f2f88106ed@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/24/2017 10:56 PM, Corey Minyard wrote:
> Oops, yes, this is an issue.
> 
> However, it should probably depend on IPMI_HANDLER, not the individual interface types.
> 

Thanks for the review. I posted V3 with your recommendation.

> -corey


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
