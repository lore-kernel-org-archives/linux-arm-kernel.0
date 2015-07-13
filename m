From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Jul 2015 11:11:58 +0100
Subject: [PATCH] arm64: Remove clk-provider.h include
In-Reply-To: <1436568657-26243-1-git-send-email-sboyd@codeaurora.org>
References: <1436568657-26243-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150713101158.GA18748@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 03:50:57PM -0700, Stephen Boyd wrote:
> This file doesn't use the clk provider APIs. Remove the include.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Please ack if you want this to go through the clk-tree (along
> with quite a few other patches that do the same thing). Otherwise,
> it's fine if it's applied to the arm64 tree.

Fine by me to go through the clock tree.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
