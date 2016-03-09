From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 8 Mar 2016 21:55:26 -0800
Subject: [PATCH v3 7/9] KVM: arm/arm64: arch_timer: Rely on the arch
 timer to parse the firmware tables
In-Reply-To: <1457436573-6180-8-git-send-email-julien.grall@arm.com>
References: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
 <1457436573-6180-8-git-send-email-julien.grall@arm.com>
Message-ID: <20160309055526.GK26583@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 11:29:31AM +0000, Julien Grall wrote:
> The firmware table is currently parsed by the virtual timer code in
> order to retrieve the virtual timer interrupt. However, this is already
> done by the arch timer driver.
> 
> To avoid code duplication, use the newly function arch_timer_get_kvm_info()
> which return all the information required by the virtual timer code.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
