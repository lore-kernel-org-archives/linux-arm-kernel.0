From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 May 2014 11:44:06 -0700
Subject: [PATCH 2/3] ARM: msm: Silence readb/writeb warnings due to
 missing IOMEM()
In-Reply-To: <1393467394-10907-3-git-send-email-sboyd@codeaurora.org>
References: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
 <1393467394-10907-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140527184406.GA27420@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 06:16:33PM -0800, Stephen Boyd wrote:
> TROUT_CPLD_BASE needs the IOMEM() treatment to avoid warnings
> from the read/writeb functions.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mach-msm/board-trout-gpio.c | 2 +-
>  arch/arm/mach-msm/board-trout.c      | 2 +-
>  arch/arm/mach-msm/board-trout.h      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied to next/fixes-non-critical.


-Olof
