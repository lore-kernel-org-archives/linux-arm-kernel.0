From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Dec 2015 17:42:50 +0000
Subject: [PATCH v4] arm64: run-time detection for aarch32 support
In-Reply-To: <1450454429-22976-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450454429-22976-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151218174250.GD30229@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index faad6df..1053cd7 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -23,6 +23,7 @@
>   */
>  #include <asm/ptrace.h>
>  #include <asm/user.h>
> +#include <asm/cpufeature.h>

Nit: please keep these ordered alphabetically.

Mark.
