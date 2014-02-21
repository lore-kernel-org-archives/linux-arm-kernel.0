From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Feb 2014 11:36:52 +0000
Subject: [PATCH 1/1] arm64: enable processor debug state for secondary cpus
In-Reply-To: <1392959630-31314-1-git-send-email-vijay.kilari@gmail.com>
References: <1392959630-31314-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20140221113652.GE5747@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 05:13:49AM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> processor debug state PSTATE.D is unmasked in smp call
> clear_os_lock for secondary cpus. So debug state is still
> masked in normal kernel context.  With this patch, unmask
> debug state on secondary boot for the cpus in normal kernel
> context. Now kgdb tests passed with multicore.
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks. Applied.

The whole series should appear in -next sometime after -rc4.

-- 
Catalin
