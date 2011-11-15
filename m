From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 15 Nov 2011 14:03:14 +0400
Subject: [PATCH v2 4/5] davinci: create new common platform header for
 davinci
In-Reply-To: <1321283357-27698-5-git-send-email-manjunath.hadli@ti.com>
References: <1321283357-27698-1-git-send-email-manjunath.hadli@ti.com>
 <1321283357-27698-5-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4EC238E2.3040600@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-11-2011 19:09, Manjunath Hadli wrote:

> remove the code from individual platform header files for
> dm365, dm355, dm644x and dm646x and consolidate it into a
> single and common header file davinci_common.h.
> Include the new header file in individual platform header
> files as a pre-cursor for deleting these headers in follow
> up patches.

> Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>
> ---
>   .../arm/mach-davinci/include/mach/davinci_common.h |   88 ++++++++++++++++++++
>   arch/arm/mach-davinci/include/mach/dm355.h         |   18 +----
>   arch/arm/mach-davinci/include/mach/dm365.h         |   20 +----
>   arch/arm/mach-davinci/include/mach/dm644x.h        |   15 +---
>   arch/arm/mach-davinci/include/mach/dm646x.h        |   20 +----
>   5 files changed, 92 insertions(+), 69 deletions(-)
>   create mode 100644 arch/arm/mach-davinci/include/mach/davinci_common.h

> diff --git a/arch/arm/mach-davinci/include/mach/davinci_common.h b/arch/arm/mach-davinci/include/mach/davinci_common.h
> new file mode 100644
> index 0000000..a859318
> --- /dev/null
> +++ b/arch/arm/mach-davinci/include/mach/davinci_common.h

    Why not call it just davinci.h?

WBR, Sergei
