From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Aug 2016 08:29:59 +0100
Subject: [PATCH 1/1] arm64: Remove stack duplicating code from jprobes
In-Reply-To: <1470861891-13315-1-git-send-email-dave.long@linaro.org>
References: <1470861891-13315-1-git-send-email-dave.long@linaro.org>
Message-ID: <57AC2977.40507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/16 21:44, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Because the arm64 calling standard allows stacked function arguments to be
> anywhere in the stack frame, do not attempt to duplicate the stack frame for
> jprobes handler functions.
> 
> Documenation changes to describe this issue have been broken out into a

nit: "Documentation"

> separate patch in order to simultaneously address them in other
> architecture(s).
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
