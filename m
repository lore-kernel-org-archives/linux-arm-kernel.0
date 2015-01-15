From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jan 2015 11:52:57 +0000
Subject: [PATCH] ARM64: kernel: add support for cpu cache information
In-Reply-To: <1420713754-13734-1-git-send-email-sudeep.holla@arm.com>
References: <1420713754-13734-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20150115115257.GA2329@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 10:42:34AM +0000, Sudeep Holla wrote:
> This patch adds support for cacheinfo on ARM64.
> 
> On ARMv8, the cache hierarchy can be identified through Cache Level ID
> (CLIDR) register while the cache geometry is provided by Cache Size ID
> (CCSIDR) register.
> 
> Since the architecture doesn't provide any way of detecting the cpus
> sharing particular cache, device tree is used for the same purpose.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org

Thanks Sudeep. I'll queue this for 3.20.

-- 
Catalin
