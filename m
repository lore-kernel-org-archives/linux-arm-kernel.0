From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 11 Dec 2015 22:19:28 +0100
Subject: [PATCH v3 02/22] arm64: KVM: Add a HYP-specific header file
In-Reply-To: <1449485618-9443-3-git-send-email-marc.zyngier@arm.com>
References: <1449485618-9443-1-git-send-email-marc.zyngier@arm.com>
 <1449485618-9443-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151211211928.GG27689@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 10:53:18AM +0000, Marc Zyngier wrote:
> In order to expose the various EL2 services that are private to
> the hypervisor, add a new hyp.h file.
> 
> So far, it only contains mundane things such as section annotation
> and VA manipulation.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
