From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 26 Jan 2017 14:22:26 +0100
Subject: [PATCH 3/3] arm/arm64: KVM: Get rid of KVM_MEMSLOT_INCOHERENT
In-Reply-To: <1485358591-12278-4-git-send-email-marc.zyngier@arm.com>
References: <1485358591-12278-1-git-send-email-marc.zyngier@arm.com>
 <1485358591-12278-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20170126132226.GZ15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 03:36:31PM +0000, Marc Zyngier wrote:
> KVM_MEMSLOT_INCOHERENT is not used anymore, as we've killed its
> only use in the arm/arm64 MMU code. Let's remove the last artifacts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
