From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 17 Nov 2011 14:35:49 +0400
Subject: [PATCH v3 4/5] ARM: davinci: create new common platform header
 for davinci
In-Reply-To: <1321525138-3928-5-git-send-email-manjunath.hadli@ti.com>
References: <1321525138-3928-1-git-send-email-manjunath.hadli@ti.com>
 <1321525138-3928-5-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4EC4E385.7030101@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-11-2011 14:18, Manjunath Hadli wrote:

> remove the code from individual platform header files for
> dm365, dm355, dm644x and dm646x and consolidate it into a
> single and common header file davinci_common.h.
> Include the new header file in individual platform header
> files as a pre-cursor for deleting these headers in follow
> up patches.

> Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>

    Sorry, didn't notice something in the first review...

> diff --git a/arch/arm/mach-davinci/include/mach/davinci.h b/arch/arm/mach-davinci/include/mach/davinci.h
> new file mode 100644
> index 0000000..49bf2f3
> --- /dev/null
> +++ b/arch/arm/mach-davinci/include/mach/davinci.h
> @@ -0,0 +1,88 @@
> +/*
> + * This file contains the processor specific definitions
> + * of the TI DM644x, DM355, DM365, and DM646X.

    DM646x for consistency.

> +/* DM644X function declarations */

    DM644x for consistency.

> +/* DM646X function declarations */

    DM646x for consistency.

WBR, Sergei
