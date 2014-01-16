From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Jan 2014 13:47:38 +0000
Subject: [PATCH v6 1/3] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <1387453851-19341-2-git-send-email-vijay.kilari@gmail.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
 <1387453851-19341-2-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20140116134738.GB7496@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:50:49AM +0000, vijay.kilari at gmail.com wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/kgdb.h
[...]
> +#ifndef __ARM_KGDB_H__
> +#define __ARM_KGDB_H__
[...]
> +#endif /* __ASM_KGDB_H__ */

Nitpick (while you are addressing the other issues): please change
header guards to __ASM_KGDB_H for consistency with most of the other
files.

Thanks.

-- 
Catalin
