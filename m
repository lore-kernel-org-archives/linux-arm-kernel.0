From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:44:59 +0100
Subject: [PATCH v2 17/28] ARM: KVM: Add populating of fault data structure
In-Reply-To: <1454583645-10144-18-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-18-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184459.GU5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:34AM +0000, Marc Zyngier wrote:
> On guest exit, we must take care of populating our fault data
> structure so that the host code can handle it. This includes
> resolving the IPA for permission faults, which can result in
> restarting the guest.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
