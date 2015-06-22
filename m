From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Jun 2015 12:09:33 +0100
Subject: [PATCH 1/2] arm64: qcom: Add define for ARMv8 implementer (MIDR)
In-Reply-To: <558497A5.4020700@codeaurora.org>
References: <1434146263-30972-1-git-send-email-timur@codeaurora.org>
 <20150615105933.GE17322@e104818-lin.cambridge.arm.com>
 <558497A5.4020700@codeaurora.org>
Message-ID: <20150622110932.GB16018@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 05:28:53PM -0500, Timur Tabi wrote:
> On 06/15/2015 05:59 AM, Catalin Marinas wrote:
> >I think this patch together with the second one could go through the kvm
> >tree. For the core arm64 part:
> >
> >Acked-by: Catalin Marinas<catalin.marinas@arm.com>
> 
> Suzuki Poulose posted a patch that adds generic support for ARMv8 KVM
> targets.  I want to drop my second patch, so can we pick up this first patch
> through the ARM tree?

So if the second patch is no longer needed, what's using this patch? I
would defer merging it until actually required in some part of the
kernel.

-- 
Catalin
