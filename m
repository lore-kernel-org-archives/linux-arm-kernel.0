From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 05 Feb 2014 23:23:25 +0300
Subject: [PATCH v3 0/6] IIO pulse capture support for TI ECAP
In-Reply-To: <1391626901-31684-1-git-send-email-mporter@linaro.org>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org>
Message-ID: <52F29DBD.9050305@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/05/2014 10:01 PM, Matt Porter wrote:

[...]

> This series adds support for PWM capture devices within IIO and
> adds a TI ECAP IIO driver.

> PWM capture devices are supported using a new IIO "pulse" channel type.

> The IIO ECAP driver implements interrupt driven triggered buffer capture
> only as raw sample reads are not applicable to this hardware.
> Initially, the driver supports a single pulse width measurement with
> configurable polarity. The ECAP hardware can support measurement of a
> complete period and duty cycle but this is not yet implemented.

    How about pulse counting? I have the hardware that can also count pulses 
in addition to measuring the periods, so I'm interested in this work 
(initially I supported it in driver/misc/ but it got turned down for iio).

WBR, Sergei
