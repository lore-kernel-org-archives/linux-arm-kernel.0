From: k.debski@samsung.com (Kamil Debski)
Date: Fri, 01 Apr 2016 10:29:57 +0200
Subject: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where
 appropriate
In-Reply-To: <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <00e701d18bf0$ade6efe0$09b4cfa0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

From: Boris Brezillon [mailto:boris.brezillon at free-electrons.com]
Sent: Wednesday, March 30, 2016 10:04 PM
Subject: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where
appropriate
> 
> The PWM framework has clarified the concept of reference PWM config (the
> platform dependent config retrieved from the DT or the PWM lookup table)
> and real PWM state.
> 
> Use pwm_get_args() when the PWM user wants to retrieve this reference
> config and not the current state.
> 
> This is part of the rework allowing the PWM framework to support hardware
> readout and expose real PWM state even when the PWM has just been
> requested (before the user calls pwm_config/enable/disable()).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Kamil Debski <k.debski@samsung.com>

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland
