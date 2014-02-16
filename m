From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 15 Feb 2014 23:35:41 -0300
Subject: [PATCH v2 07/23] ARM: Kirkwood: ioremap memory control register
In-Reply-To: <1392459621-24003-8-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-8-git-send-email-andrew@lunn.ch>
Message-ID: <20140216023540.GD8926@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 11:20:05AM +0100, Andrew Lunn wrote:
> To allow removal of the global map of registers, make the pm code
> ioremap the registers it needs.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h | 1 +
>  arch/arm/mach-kirkwood/pm.c                       | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
