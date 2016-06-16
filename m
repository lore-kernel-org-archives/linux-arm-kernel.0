From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Jun 2016 17:45:36 +0100
Subject: [PATCH v4] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <1466095192-106891-1-git-send-email-glider@google.com>
References: <1466095192-106891-1-git-send-email-glider@google.com>
Message-ID: <20160616164536.GH18752@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 06:39:52PM +0200, Alexander Potapenko wrote:
> Add ARCH_HAS_KCOV to ARM64 config. To avoid potential crashes, disable
> instrumentation of the files in arch/arm64/kvm/hyp/*.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: James Morse <james.morse@arm.com>

Thanks. I'll queue it for 4.8.

-- 
Catalin
