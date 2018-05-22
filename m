From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 May 2018 15:29:31 +0100
Subject: [PATCH] arm64: Kconfig: Enable LSE atomics by default
In-Reply-To: <1526926462-19214-1-git-send-email-will.deacon@arm.com>
References: <1526926462-19214-1-git-send-email-will.deacon@arm.com>
Message-ID: <4ace3bc1-4c6e-d6f1-9a62-0dcaeba32b29@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/18 19:14, Will Deacon wrote:
> Now that we're seeing CPUs shipping with LSE atomics, default them to
> 'on' in Kconfig. CPUs without the instructions will continue to use
> LDXR/STXR-based sequences, but they will be placed out-of-line by the
> compiler.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
