From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 May 2013 11:53:54 +0100
Subject: [PATCH v4 24/32] arm64: KVM: 32bit conditional execution emulation
In-Reply-To: <1368540840-26750-25-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-25-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130523105354.GF16722@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:52PM +0100, Marc Zyngier wrote:
> As conditional instructions can trap on AArch32, add the thinest
> possible emulation layer to keep 32bit guests happy.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
