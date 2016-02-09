From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:42:23 +0100
Subject: [PATCH v2 06/28] ARM: KVM: Add a HYP-specific header file
In-Reply-To: <1454583645-10144-7-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184223.GK5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:23AM +0000, Marc Zyngier wrote:
> In order to expose the various HYP services that are private to
> the hypervisor, add a new hyp.h file.
> 
> So far, it only contains mundane things such as section annotation
> and VA manipulation.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
