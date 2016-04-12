From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 12 Apr 2016 07:44:03 +0200
Subject: [PATCH v6 02/10] clocksource: arm_arch_timer: Extend
 arch_timer_kvm_info to get the virtual IRQ
In-Reply-To: <1460388780-914-3-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-3-git-send-email-julien.grall@arm.com>
Message-ID: <20160412054403.GB16636@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 04:32:52PM +0100, Julien Grall wrote:
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
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
