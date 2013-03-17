From: will.deacon@arm.com (Will Deacon)
Date: Sun, 17 Mar 2013 14:29:29 +0000
Subject: [PATCH 1/3] ARM: Clear IDIVT hwcap if CONFIG_ARM_THUMB=n
In-Reply-To: <1363138321-27849-2-git-send-email-sboyd@codeaurora.org>
References: <1363138321-27849-1-git-send-email-sboyd@codeaurora.org>
 <1363138321-27849-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130317142929.GD19071@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 01:31:59AM +0000, Stephen Boyd wrote:
> Don't advertise support for the SDIV/UDIV thumb instructions if
> the kernel is not compiled with support for thumb userspace. This
> is in line with how we remove the THUMB hwcap in these
> configurations.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
