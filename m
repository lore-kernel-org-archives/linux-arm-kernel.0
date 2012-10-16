From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Oct 2012 14:23:24 +0100
Subject: [PATCH 1/1] ARM64: Remove duplicate inclusion of mmu_context.h
 in smp.c
In-Reply-To: <1350116758-624-1-git-send-email-sachin.kamat@linaro.org>
References: <1350116758-624-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20121016132324.GB29357@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2012 at 09:25:58AM +0100, Sachin Kamat wrote:
> asm/mmu_context.h was included twice.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied. Thanks.

-- 
Catalin
