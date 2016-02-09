From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:42:13 +0100
Subject: [PATCH v2 04/28] ARM: KVM: Move CP15 array into the CPU context
 structure
In-Reply-To: <1454583645-10144-5-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184213.GI5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:21AM +0000, Marc Zyngier wrote:
> Continuing our rework of the CPU context, we now move the CP15
> array into the CPU context structure. As this causes quite a bit
> of churn, we introduce the vcpu_cp15() macro that abstract the
> location of the actual array. This will probably help next time
> we have to revisit that code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
