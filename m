From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 15:01:48 -0500
Subject: [PATCH 2/7] pwm: omap-dmtimer: Allow for setting dmtimer clock
 source
In-Reply-To: <1462634508-24961-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20160509200148.GA19811@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 07, 2016 at 06:21:43PM +0300, Ivaylo Dimitrov wrote:
> OMAP GP timers can have different input clocks that allow different PWM
> frequencies. However, there is no other way of setting the clock source but
> through clocks or clock-names properties of the timer itself. This limits
> PWM functionality to only the frequencies allowed by the particular clock
> source. Allowing setting the clock source by PWM rather than by timer
> allows different PWMs to have different ranges by not hard-wiring the clock
> source to the timer.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt |  4 ++++
>  drivers/pwm/pwm-omap-dmtimer.c                             | 12 +++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
