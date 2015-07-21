From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Jul 2015 11:17:30 -0700
Subject: [RFC PATCH 4/4] iommu/arm-smmu: Add support for specifying
 regulators
In-Reply-To: <1437152005-25092-5-git-send-email-sricharan@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
 <1437152005-25092-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <55AE8CBA.90805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2015 09:53 AM, Sricharan R wrote:
> From: Mitchel Humpherys <mitchelh@codeaurora.org>
>
> This adds the support to turn on the regulators required
> for SMMUs. It is turned on during the SMMU probe and remains
> 'on' till the device exists.

The device always exists. Until the driver is removed perhaps?

>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

We won't be using regulators. We'll be using power domains instead so 
please rewrite this patch accordingly.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
