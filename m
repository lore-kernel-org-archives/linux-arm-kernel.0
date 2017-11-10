From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 10 Nov 2017 08:14:00 -0600
Subject: [PATCH V2 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <3ca59a37-e8f8-a2cf-fa3a-f4ee6d544dcd@codeaurora.org>
References: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
 <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
 <e781fe6c-a4ad-4a96-c705-dfcd9a8d10b0@arm.com>
 <3ca59a37-e8f8-a2cf-fa3a-f4ee6d544dcd@codeaurora.org>
Message-ID: <753b9001-b269-c2b8-be60-9a81f08d60c5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2017 08:03 AM, Sinan Kaya wrote:
> I did post v3 with this approach. However, I could not really find a ACPI function that
> returns the driver data very similar to of_device_get_match_data(). The only thing
> that is closer is acpi_match_device().

This is what I do in the EMAC driver:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c#n245

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
