From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 May 2013 12:02:06 +0100
Subject: [PATCH v4 27/32] arm64: KVM: 32bit specific register world switch
In-Reply-To: <1368540840-26750-28-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-28-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130523110206.GI16722@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:55PM +0100, Marc Zyngier wrote:
> Allow registers specific to 32bit guests to be saved/restored
> during the world switch.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
