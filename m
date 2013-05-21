From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 May 2013 16:27:06 +0100
Subject: [PATCH v4 19/32] arm64: KVM: Plug the arch timer
In-Reply-To: <1368540840-26750-20-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-20-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130521152706.GK27002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:47PM +0100, Marc Zyngier wrote:
> Add support for the in-kernel timer emulation.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I think same comment as one of the previous patches, you could get rid
of some ISBs if you get an ERET anyway. Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
