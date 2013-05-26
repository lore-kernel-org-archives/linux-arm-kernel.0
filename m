From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 26 May 2013 13:59:57 -0400
Subject: [PATCH v3 2/3] arm: kirkwood: Instantiate cpufreq driver
In-Reply-To: <1359281244-31455-3-git-send-email-andrew@lunn.ch>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-3-git-send-email-andrew@lunn.ch>
Message-ID: <20130526175957.GD31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 11:07:23AM +0100, Andrew Lunn wrote:
> Register a platform driver structure for the cpufreq driver.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/Kconfig                                  |    1 +
>  arch/arm/mach-kirkwood/board-dt.c                 |    3 ++-
>  arch/arm/mach-kirkwood/common.c                   |   23 +++++++++++++++++++++
>  arch/arm/mach-kirkwood/common.h                   |    2 ++
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 ++
>  5 files changed, 30 insertions(+), 1 deletion(-)

Thanks again to Andrew for digging this one up.  Applied to mvebu/soc

thx,

Jason.
