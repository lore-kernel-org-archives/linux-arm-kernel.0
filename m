From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 14 Dec 2015 12:07:29 +0100
Subject: [PATCH v3 22/22] arm64: KVM: Remove weak attributes
In-Reply-To: <1449485618-9443-23-git-send-email-marc.zyngier@arm.com>
References: <1449485618-9443-1-git-send-email-marc.zyngier@arm.com>
 <1449485618-9443-23-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151214110729.GC4120@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 10:53:38AM +0000, Marc Zyngier wrote:
> As we've now switched to the new world switch implementation,
> remove the weak attributes, as nobody is supposed to override
> it anymore.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
