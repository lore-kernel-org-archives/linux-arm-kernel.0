From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:42:57 +0100
Subject: [PATCH v2 13/28] ARM: KVM: Add banked registers save/restore
In-Reply-To: <1454583645-10144-14-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184257.GQ5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:30AM +0000, Marc Zyngier wrote:
> Banked registers are one of the many perks of the 32bit architecture,
> and the world switch needs to cope with it.
> 
> This requires some "special" accessors, as these are not accessed
> using a standard coprocessor instruction.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
