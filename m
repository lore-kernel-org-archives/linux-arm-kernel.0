From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 6 Feb 2014 20:08:51 -0800
Subject: [PATCH v3 11/11] ARM: KVM: trap VM system registers until MMU
 and caches are ON
In-Reply-To: <1391630151-7875-12-git-send-email-marc.zyngier@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
 <1391630151-7875-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140207040851.GP9157@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 07:55:51PM +0000, Marc Zyngier wrote:
> In order to be able to detect the point where the guest enables
> its MMU and caches, trap all the VM related system registers.
> 
> Once we see the guest enabling both the MMU and the caches, we
> can go back to a saner mode of operation, which is to leave these
> registers in complete control of the guest.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
