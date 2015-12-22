From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Dec 2015 14:29:22 +0000
Subject: [PATCH v6 16/20] arm64: signal32: move ilp32 and aarch32 common
 code to separated file
In-Reply-To: <1450215766-14765-17-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-17-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151222142921.GB1302@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 12:42:42AM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/kernel/signal32_common.c b/arch/arm64/kernel/signal32_common.c
> new file mode 100644
> index 0000000..446c7c0
> --- /dev/null
> +++ b/arch/arm64/kernel/signal32_common.c
> @@ -0,0 +1,116 @@
> +/*
> + * Based on arch/arm/kernel/signal.c
> + *
> + * Copyright (C) 1995-2009 Russell King
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2015 Cavium Metworks.

I mentioned this before - moving unmodified code around shouldn't grant
Cavium new rights (but IANAL).

-- 
Catalin
