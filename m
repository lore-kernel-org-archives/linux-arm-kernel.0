From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:42:18 +0100
Subject: [PATCH v2 05/28] ARM: KVM: Move GP registers into the CPU
 context structure
In-Reply-To: <1454583645-10144-6-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184218.GJ5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:22AM +0000, Marc Zyngier wrote:
> Continuing our rework of the CPU context, we now move the GP
> registers into the CPU context structure.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
