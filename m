From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Apr 2013 14:05:09 +0530
Subject: [PATCH v3 0/3] Platform support for EHRPWM & ECAP devices in
 DAVINCI.
In-Reply-To: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
References: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
Message-ID: <515A983D.8040907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/25/2013 1:19 PM, Philip Avinash wrote:
> Add platform support for EHRPWM and ECAP by providing clock nodes and
> device tree nodes.
> This series depends on [1] and [2] and is available for testing at [3].
> Tested for back light support in da850 EVM with EHRPWM PWM device.
> 
> [1] http://gitorious.org/linux-davinci/linux-davinci/trees/davinci-for-v3.9/dt-2
> [2] https://gitorious.org/linux-pwm/linux-pwm/trees/for-next
> [3] https://github.com/avinashphilip/am335x_linux/tree/davinci-for-v3.9_soc_pwm
> 
> Note:
> DT support for EHRPWM backlight has not been added in da850-evm.dts as there is
> conflicting pin-mux requirement with SPI flash.

Can you check if this is really true even in newer boards (have a look
at the latest schematics)? I remember this used to be a problem in very
early versions but was fixed later.

Thanks,
Sekhar
