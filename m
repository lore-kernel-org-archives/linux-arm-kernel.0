From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 May 2018 17:16:23 +0100
Subject: [PATCH v7 02/16] arm64: Use update{,_tsk}_thread_flag()
In-Reply-To: <1525882385-29181-3-git-send-email-Dave.Martin@arm.com>
References: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
 <1525882385-29181-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180510161622.igarkxhbcrs4m4yo@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:12:51PM +0100, Dave P Martin wrote:
> This patch uses the new update_thread_flag() helpers to simplify a
> couple of if () set; else clear; constructs.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
