From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Mar 2017 13:00:03 +0100
Subject: [PATCH v3 3/4] arm64: dts: rockchip: describe Gru/Kevin OPPs +
 CPU regulators
In-Reply-To: <20170320235344.126298-4-briannorris@chromium.org>
References: <20170320235344.126298-1-briannorris@chromium.org>
 <20170320235344.126298-4-briannorris@chromium.org>
Message-ID: <2038128.kuAi12yfFv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 20. M?rz 2017, 16:53:43 CET schrieb Brian Norris:
> Used for Gru/Kevin only, as they're the only ones which have a described
> CPU regulator. Also, I'm not sure we've validated this table non-Gru
> boards.
> 
> At the same time, partially describe PWM regulators for Gru, so cpufreq
> doesn't think it can crank up the clock speed without changing the
> voltage. However, we don't yet have the DT bindings to fully describe
> the Over Voltage Protection (OVP) circuits on these boards. Without that
> description, we might end up changing the voltage too much, too fast.
> 
> Add the pwm-regulator descriptions and associate the CPU OPPs, but leave
> them disabled.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

applied for 4.12 with Enric's Tested-tag after some small reordering of nodes/
properties.


Heiko
