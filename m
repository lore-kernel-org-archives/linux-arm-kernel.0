From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 23 Mar 2017 10:56:07 -0500
Subject: [PATCH] ACPI / IPMI: allow ACPI_IPMI with IPMI_SSIF
In-Reply-To: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
References: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
Message-ID: <f444a7c8-037c-d6dd-3cef-769960c95d08@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2017 10:53 AM, Sinan Kaya wrote:
> +	depends on IPMI_SI||IPMI_SSIF

Blank spaces around ||.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
