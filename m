From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jul 2015 19:04:41 +0100
Subject: [PATCH 03/13] arm64: Add ARM64_HAS_VIRT_HOST_EXTN feature
In-Reply-To: <1436372356-30410-4-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150716180441.GR26390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 05:19:06PM +0100, Marc Zyngier wrote:
> Add a new ARM64_HAS_VIRT_HOST_EXTN features to indicate that the
> CPU has the ARMv8,1 VHE capability.
> 
> This will be used to trigger kernel patching in KVM.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
