From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 7 Jan 2015 14:05:25 +0100
Subject: [PATCH v15 06/11] KVM: arm: dirty logging write protect support
In-Reply-To: <1418628488-3696-7-git-send-email-m.smarduch@samsung.com>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
 <1418628488-3696-7-git-send-email-m.smarduch@samsung.com>
Message-ID: <20150107130525.GF21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 11:28:03PM -0800, Mario Smarduch wrote:
> Add support to track dirty pages between user space KVM_GET_DIRTY_LOG ioctl
> calls. We call kvm_get_dirty_log_protect() function to do most of the work.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
