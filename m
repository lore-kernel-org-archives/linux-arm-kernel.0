From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Mar 2017 14:37:39 -0500
Subject: [PATCH v2 2/2] drivers: pwm: pwm-atmel: enable PWM on sama5d2
In-Reply-To: <1488468525-28726-3-git-send-email-claudiu.beznea@microchip.com>
References: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
 <1488468525-28726-3-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170315193739.cebry3tafla5zz5v@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 05:28:45PM +0200, Claudiu Beznea wrote:
> sama5d2 can use the same atmel_pwm_data as sama5d3.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> ---
>  Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
>  drivers/pwm/pwm-atmel.c                             | 3 +++
>  2 files changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
