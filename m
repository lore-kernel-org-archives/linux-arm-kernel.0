From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 19 Jun 2015 17:28:53 -0500
Subject: [PATCH 1/2] arm64: qcom: Add define for ARMv8 implementer (MIDR)
In-Reply-To: <20150615105933.GE17322@e104818-lin.cambridge.arm.com>
References: <1434146263-30972-1-git-send-email-timur@codeaurora.org>
 <20150615105933.GE17322@e104818-lin.cambridge.arm.com>
Message-ID: <558497A5.4020700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2015 05:59 AM, Catalin Marinas wrote:
> I think this patch together with the second one could go through the kvm
> tree. For the core arm64 part:
>
> Acked-by: Catalin Marinas<catalin.marinas@arm.com>

Suzuki Poulose posted a patch that adds generic support for ARMv8 KVM 
targets.  I want to drop my second patch, so can we pick up this first 
patch through the ARM tree?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
