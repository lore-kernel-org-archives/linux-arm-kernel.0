From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Jun 2015 11:59:34 +0100
Subject: [PATCH 1/2] arm64: qcom: Add define for ARMv8 implementer (MIDR)
In-Reply-To: <1434146263-30972-1-git-send-email-timur@codeaurora.org>
References: <1434146263-30972-1-git-send-email-timur@codeaurora.org>
Message-ID: <20150615105933.GE17322@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 04:57:42PM -0500, Timur Tabi wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
> 
> This patch adds define for Qualcomm Technologies ARMv8 CPU
> implementer ID 0x51 and part number for Kryo in asm/cputype.h.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

I think this patch together with the second one could go through the kvm
tree. For the core arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
