From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Feb 2016 14:48:31 +0000
Subject: [PATCH v3 20/23] arm64: perf: Count EL2 events if the kernel is
 running in HYP
In-Reply-To: <1454522416-6874-21-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <1454522416-6874-21-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160208144831.GP6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:00:13PM +0000, Marc Zyngier wrote:
> When the kernel is running in HYP (with VHE), it is necessary to
> include EL2 events if the user requests counting kernel or
> hypervisor events.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
