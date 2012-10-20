From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Oct 2012 13:14:54 +0200
Subject: [PATCH 3/3] ARM: Kirkwood: checkpatch cleanups
In-Reply-To: <1350729736-14539-3-git-send-email-andrew@lunn.ch>
References: <1350729736-14539-1-git-send-email-andrew@lunn.ch>
 <1350729736-14539-3-git-send-email-andrew@lunn.ch>
Message-ID: <20121020111454.GA21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --- a/arch/arm/mach-kirkwood/cpuidle.c
> +++ b/arch/arm/mach-kirkwood/cpuidle.c
> @@ -20,7 +20,6 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>  #include <asm/proc-fns.h>
> -#include <asm/cpuidle.h>
>  #include <mach/kirkwood.h>

Upps. This breaks the build. V2 soon to be posted.

      Andrew
