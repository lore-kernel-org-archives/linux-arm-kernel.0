From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 May 2013 12:12:37 +0100
Subject: [PATCH v4 32/32] arm64: KVM: document kernel object mappings
 in HYP
In-Reply-To: <1368540840-26750-33-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-33-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130523111237.GM16722@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:14:00PM +0100, Marc Zyngier wrote:
> HYP mode has access to some of the kernel pages. Document the
> memory mapping and the offset between kernel VA and HYP VA.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
