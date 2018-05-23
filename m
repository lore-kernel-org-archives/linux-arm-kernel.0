From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 May 2018 11:34:28 +0100
Subject: [PATCH] arm64: Kconfig: Enable LSE atomics by default
In-Reply-To: <1526926462-19214-1-git-send-email-will.deacon@arm.com>
References: <1526926462-19214-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180523103427.cxe3ab6coe337qhe@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 07:14:22PM +0100, Will Deacon wrote:
> Now that we're seeing CPUs shipping with LSE atomics, default them to
> 'on' in Kconfig. CPUs without the instructions will continue to use
> LDXR/STXR-based sequences, but they will be placed out-of-line by the
> compiler.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for 4.18. Thanks.

-- 
Catalin
