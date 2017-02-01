From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 1 Feb 2017 10:31:05 -0800
Subject: [PATCH 1/2] ARM: dts: add XOADC and IIO HWMON to MSM8660/APQ8060
In-Reply-To: <20170131102114.25085-1-linus.walleij@linaro.org>
References: <20170131102114.25085-1-linus.walleij@linaro.org>
Message-ID: <20170201183105.GI10531@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 31 Jan 02:21 PST 2017, Linus Walleij wrote:

> This adds the PM8058 XOADC node to the PM8058 PMIC node,
> defines the 16 channels and further also define an IIO HWMON
> node for the channels that are used for housekeeping of
> voltages and die temperature for the PMIC chip die.
> 
> Tested on the APQ8060 DragonBoard:
> cd /sys/class/hwmon/hwmon0
> cat in2_input
> 4773 (DC mains ~5V)
> cat in4_input
> 625  (0.625V reference voltage)
> cat in5_input
> 1250 (1.25V reference voltage)
> cat temp1_input
> 35852 (die temperature)
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
