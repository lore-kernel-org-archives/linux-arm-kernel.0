From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Apr 2016 17:03:34 +0100
Subject: [PATCH 25/25] arm64:ilp32: add ARM64_ILP32 to Kconfig
In-Reply-To: <1459894127-17698-26-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-26-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160429160334.GD30316@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 01:08:47AM +0300, Yury Norov wrote:
> +config ARM64_ILP32
> +	bool "Kernel support for ILP32"
> +	select COMPAT_WRAPPER
> +	help
> +	  This option enables support for AArch64 ILP32 user space.  ILP32
> +	  is an ABI where long and pointers are 32bits but it uses the AARCH64
> +	  instruction set.

Is there any penalty for AArch32 tasks when selecting COMPAT_WRAPPER?

-- 
Catalin
