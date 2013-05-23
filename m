From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 May 2013 12:00:26 +0100
Subject: [PATCH v4 25/32] arm64: KVM: 32bit handling of coprocessor traps
In-Reply-To: <1368540840-26750-26-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-26-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130523110025.GG16722@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:53PM +0100, Marc Zyngier wrote:
> Provide the necessary infrastructure to trap coprocessor accesses that
> occur when running 32bit guests.
> 
> Also wire SMC and HVC trapped in 32bit mode while were at it.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
