From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2016 17:16:09 +0100
Subject: [PATCH 1/2] arm64: Provide "model name" in /proc/cpuinfo for
 PER_LINUX32 tasks
In-Reply-To: <1464706504-25224-2-git-send-email-catalin.marinas@arm.com>
References: <1464706504-25224-1-git-send-email-catalin.marinas@arm.com>
 <1464706504-25224-2-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160531161609.GM24936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 03:55:03PM +0100, Catalin Marinas wrote:
> This patch brings the PER_LINUX32 /proc/cpuinfo format more in line with
> the 32-bit ARM one by providing an additional line:
> 
> model name      : ARMv8 Processor rev X (v8l)
> 
> Cc: <stable@vger.kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/elf.h | 4 ++--
>  arch/arm64/kernel/cpuinfo.c  | 8 +++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)

Looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
