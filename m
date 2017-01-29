From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 29 Jan 2017 11:44:12 +0000
Subject: [RFC v2 01/10] KVM: arm/arm64: Abstract virtual timer context
 into separate structure
In-Reply-To: <1485479100-4966-2-git-send-email-jintack@cs.columbia.edu>
 (Jintack Lim's message of "Thu, 26 Jan 2017 20:04:51 -0500")
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
 <1485479100-4966-2-git-send-email-jintack@cs.columbia.edu>
Message-ID: <86bmuq9jlf.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27 2017 at 01:04:51 AM, Jintack Lim <jintack@cs.columbia.edu> wrote:
> Abstract virtual timer context into a separate structure and change all
> callers referring to timer registers, irq state and so on. No change in
> functionality.
>
> This is about to become very handy when adding the EL1 physical timer.
>
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

          M.
-- 
Jazz is not dead. It just smells funny.
