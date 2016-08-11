From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 Aug 2016 17:39:19 +0100
Subject: [PATCH 1/1] arm64: Remove stack duplicating code from jprobes
In-Reply-To: <1470861891-13315-1-git-send-email-dave.long@linaro.org>
References: <1470861891-13315-1-git-send-email-dave.long@linaro.org>
Message-ID: <20160811163919.GE18366@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 04:44:51PM -0400, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Because the arm64 calling standard allows stacked function arguments to be
> anywhere in the stack frame, do not attempt to duplicate the stack frame for
> jprobes handler functions.
> 
> Documenation changes to describe this issue have been broken out into a
> separate patch in order to simultaneously address them in other
> architecture(s).
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied to arm64 fixes/core with Marc's ack and the spelling corrected.

Thanks.

-- 
Catalin
