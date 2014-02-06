From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 6 Feb 2014 15:20:46 +0100 (CET)
Subject: [PATCH 2/2] ARM64: powernv: remove redundant cpuidle_idle_call()
In-Reply-To: <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <alpine.DEB.2.02.1402061520340.21991@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Feb 2014, Nicolas Pitre wrote:

> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
