From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Oct 2013 18:03:50 +0100
Subject: [PATCH] arm64: Remove duplicate DEBUG_STACK_USAGE config
In-Reply-To: <1380660523-19036-1-git-send-email-sboyd@codeaurora.org>
References: <1380660523-19036-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131002170349.GF29794@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 09:48:43PM +0100, Stephen Boyd wrote:
> This config item already exists generically in lib/Kconfig.debug.
> Remove the duplicate config in arm64.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks. Applied.

-- 
Catalin
