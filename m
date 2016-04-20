From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 20 Apr 2016 09:53:47 +0100
Subject: [PATCH] vexpress/spc: Remove CLK_IS_ROOT
In-Reply-To: <1461116215-1517-1-git-send-email-sboyd@codeaurora.org>
References: <1461116215-1517-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5717439B.20801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/04/16 02:36, Stephen Boyd wrote:
> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

FWIW:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
