From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Feb 2016 12:55:30 +0000
Subject: [PATCH v6 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <1455512263-18183-2-git-send-email-qnguyen@apm.com>
References: <1455512263-18183-1-git-send-email-qnguyen@apm.com>
 <1455512263-18183-2-git-send-email-qnguyen@apm.com>
Message-ID: <56C1CAC2.8050709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/16 04:57, Quan Nguyen wrote:
> Enable X-Gene standby GPIO controller as interrupt controller to provide
> its own resources. This avoids ambiguity where GIC interrupt resource is
> use as X-Gene standby GPIO interrupt resource in user driver.
> 
> Signed-off-by: Y Vo <yvo@apm.com>
> Signed-off-by: Quan Nguyen <qnguyen@apm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
