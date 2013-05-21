From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 May 2013 16:20:25 +0100
Subject: [PATCH v4 17/32] arm64: KVM: Exit handling
In-Reply-To: <1368540840-26750-18-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-18-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130521152025.GI27002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:45PM +0100, Marc Zyngier wrote:
> Handle the exit of a VM, decoding the exit reason from HYP mode
> and calling the corresponding handler.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
