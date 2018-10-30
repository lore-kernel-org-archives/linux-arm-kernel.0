From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 30 Oct 2018 21:35:35 +0100
Subject: [PATCH] arm64: dts: rockchip: Use default brightness table for
 gru.
In-Reply-To: <20181016141304.21984-1-enric.balletbo@collabora.com>
References: <20181016141304.21984-1-enric.balletbo@collabora.com>
Message-ID: <3715364.6vahmuDdgq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. Oktober 2018, 16:13:04 CET schrieb Enric Balletbo i Serra:
> After commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye") the pwm_bl driver is able to calculate a default
> brightness table. The calculated table for this PWM will have more
> granularity and will be adjusted to change the brightness linearly to
> the human eye. Use that table instead of have a DT-defined table with
> less granularity.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Hi Heiko,
> 
> Note that the patch was only tested on a Samsung Chromebook Plus
> (kevin), will be very interesting if someone can test on other gru-based
> devices, like Bob, before apply this patch.
> 
> Best regards,
>  Enric

gave it a spin on Bob - works as expected - and applied for 4.21

Thanks
Heiko
