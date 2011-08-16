From: tixy@yxit.co.uk (Tixy)
Date: Tue, 16 Aug 2011 15:51:40 +0100
Subject: [PATCH 3/3] ARM: entry: Fix Thumb-2 undef handling for
	multi-CPU kernels
In-Reply-To: <1313504053-27873-4-git-send-email-dave.martin@linaro.org>
References: <1313504053-27873-1-git-send-email-dave.martin@linaro.org>
	<1313504053-27873-4-git-send-email-dave.martin@linaro.org>
Message-ID: <1313506300.2235.13.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-08-16 at 15:14 +0100, Dave Martin wrote:
[...]
> +#ifdef NEED_CPU_ARCHITECTURE
> +	.align	2
> +.LCcpu_architecture:
> +	.word	__cpu_architecture
> +#endif

What's the convention about the prefix '.LC' as opposed to just '.L'?

-- 
Tixy
