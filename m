From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:44:49 +0100
Subject: [PATCH v2 15/28] ARM: KVM: Add VFP lazy save/restore handler
In-Reply-To: <1454583645-10144-16-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-16-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184449.GS5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:32AM +0000, Marc Zyngier wrote:
> Similar to the arm64 version, add the code that deals with VFP traps,
> re-enabling VFP, save/restoring the registers and resuming the guest.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
