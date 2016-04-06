From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 Apr 2016 19:26:13 +0200
Subject: [PATCH v5 2/9] clocksource: arm_arch_timer: Extend
 arch_timer_kvm_info to get the virtual IRQ
In-Reply-To: <1459769860-6629-3-git-send-email-julien.grall@arm.com>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-3-git-send-email-julien.grall@arm.com>
Message-ID: <20160406172613.GH8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 12:37:33PM +0100, Julien Grall wrote:
> Currently, the firmware table is parsed by the virtual timer code in
> order to retrieve the virtual timer interrupt. However, this is already
> done by the arch timer driver.
> 
> To avoid code duplication, extend arch_timer_kvm_info to get the virtual
> IRQ.
> 
> Note that the KVM code will be modified in a subsequent patch.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
