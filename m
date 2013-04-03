From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 14:03:10 -0700
Subject: [PATCH v2 12/18] ARM: OMAP4: CPUidle: Avoid double idle driver
 registration
In-Reply-To: <1364205910-32392-13-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:04 +0530")
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-13-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <877gkjtjht.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> OMAP4 CPUidle driver registration call is under a loop which leads
> to calling cpuidle_register_driver twice which is not intended.
>
> Fix it by moving the driver registration outside the loop.
>
> Reported-by: Nishanth Menon <nm@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Looks good.

I've already got a for_3.10/fixes/cpuidle branch going, so I'll apply
this one there.

Kevin
