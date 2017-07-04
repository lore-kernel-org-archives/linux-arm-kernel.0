From: david.wu@rock-chips.com (David.Wu)
Date: Tue, 4 Jul 2017 14:46:29 +0800
Subject: [PATCH 3/5] pwm: rockchip: Move the configuration of polarity
 from rockchip_pwm_set_enable() to rockchip_pwm_config()
In-Reply-To: <20170703203640.697b8286@bbrezillon>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
 <1498739271-27431-4-git-send-email-david.wu@rock-chips.com>
 <20170703203640.697b8286@bbrezillon>
Message-ID: <681d6ce3-aae4-7d4f-2fec-e8af8f4f9436@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

? 2017/7/4 2:36, Boris Brezillon ??:
> Hm, maybe it's time to drop these custom hooks and implement
> pwm_apply_v1 and pwm_apply_v2 instead.

Okay, drop the enable and config hooks, only use the apply hook to 
instead them.
