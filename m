From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Sep 2014 10:16:30 +0100
Subject: [PATCH 3.17-rc4 v7 3/6] arm64: Introduce dummy version of
 asm/fiq.h
In-Reply-To: <1410970218-28847-4-git-send-email-daniel.thompson@linaro.org>
References: <1410970218-28847-1-git-send-email-daniel.thompson@linaro.org>
 <1410970218-28847-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140922091603.GC30085@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 05:10:15PM +0100, Daniel Thompson wrote:
> Drivers that are shared between arm and arm64 and which employ
> FIQ on arm cannot include asm/fiq.h without #ifdef'ing. This patch
> introduces a dummy version of asm/fiq.h to arm64 to avoid this.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
