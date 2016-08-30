From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Aug 2016 10:19:35 +0100
Subject: [PATCH ] arm64: cpuinfo: Add "model name" in /proc/cpuinfo for
 64bit tasks also
In-Reply-To: <1472461345-28219-1-git-send-email-sumitg@nvidia.com>
References: <1472461345-28219-1-git-send-email-sumitg@nvidia.com>
Message-ID: <20160830091935.GD5163@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 02:32:25PM +0530, Sumit Gupta wrote:
> Removed restriction of displaying model name for 32 bit tasks only.
> Because of this Processor details were not displayed in
> "System setting -> Details" in Ubuntu model name display is generic
> and can be printed for 64 bit also.
> 
> model name : ARMv8 Processor rev X (v8l)
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

You didn't give a reason why this is needed. For 32-bit tasks, we did it
for backwards compatibility with code checking for it.

-- 
Catalin
