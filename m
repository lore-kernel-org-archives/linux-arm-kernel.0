From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 May 2014 11:54:01 +0100
Subject: [PATCH 7/8] arm64/kexec: Add core kexec support
In-Reply-To: <64ef27888fa70b3e27ddcf4ca594fa71ab7f7777.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
 <64ef27888fa70b3e27ddcf4ca594fa71ab7f7777.1399594544.git.geoff@infradead.org>
Message-ID: <20140514105401.GF2848@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> +KEXEC FOR ARM64
> +M:     Geoff Levand <geoff@infradead.org>
> +W:     http://kernel.org/pub/linux/utils/kernel/kexec/
> +L:     kexec at lists.infradead.org
> +L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:     Maintained
> +F:     arch/arm64/machine_kexec.c
> +F:     arch/arm64/relocate_kernel.S

These entries missed the full directory name.

Anyway, this code already comes under the core arm64 MAINTAINERS entry
and it doesn't make sense to have a special kexec case. Please add a
proper header to the new files you introduce, including copyright and
author information.

-- 
Catalin
