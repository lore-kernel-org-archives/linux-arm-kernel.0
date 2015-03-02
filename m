From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 2 Mar 2015 14:14:08 -0800
Subject: [PATCH 2/6] arm_gic_kvm.c: restore config before pending IRQs
In-Reply-To: <1424880159-29348-3-git-send-email-alex.bennee@linaro.org>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-3-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150302221408.GC12902@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:02:34PM +0000, Alex Benn?e wrote:
> As there is logic to deal with the difference between edge and level
> triggered interrupts in the kernel we must ensure it knows the
> configuration of the IRQs before we restore the pending state.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
