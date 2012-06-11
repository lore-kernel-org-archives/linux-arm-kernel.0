From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jun 2012 15:31:20 +0000
Subject: [PATCH 01/14] rtc: ab8500-rtc: IRQF_ONESHOT when requesting a
 threaded IRQ
In-Reply-To: <1339428307-3850-2-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-2-git-send-email-lee.jones@linaro.org>
Message-ID: <201206111531.20468.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Lee Jones wrote:
> The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Isn't this a bug fix that should be applied to the stable kernels too?

	Arnd
