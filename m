From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 14 Mar 2013 18:06:27 +0530
Subject: [PATCH 1/3] arm: davinci: clock node support for ECAP & EHRPWM
In-Reply-To: <1363257453-24747-2-git-send-email-avinashphilip@ti.com>
References: <1363257453-24747-1-git-send-email-avinashphilip@ti.com>
 <1363257453-24747-2-git-send-email-avinashphilip@ti.com>
Message-ID: <5141C44B.1000301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 3/14/2013 4:07 PM, Philip Avinash wrote:
> Add clock node support for ECAP and EHRPWM modules.
> Also adds dummy clock for EHRWPM TBCLK to comply with pwm-tiehrpwm
> driver.

This is not right. So the version of IP used on AM335x uses a TBCLK and
that's absent on the version used on DA850? If yes, the driver should
never request clock on DA850.

Thanks,
Sekhar
