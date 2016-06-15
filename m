From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Jun 2016 11:42:34 +0100
Subject: [PATCH] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <1465984523-68478-1-git-send-email-glider@google.com>
References: <1465984523-68478-1-git-send-email-glider@google.com>
Message-ID: <20160615114234.03390155@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jun 2016 11:55:23 +0200
Alexander Potapenko <glider@google.com> wrote:

> Add ARCH_HAS_KCOV to ARM64 config. To avoid potential crashes, disable
> instrumentation of the files in arch/arm64/kvm/hyp/*.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
