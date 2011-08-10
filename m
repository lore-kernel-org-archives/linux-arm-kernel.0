From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 10 Aug 2011 14:06:59 +0100
Subject: [PATCH 02/18] led-triggers: create a trigger for CPU activity
In-Reply-To: <1312977952-2272-3-git-send-email-bryan.wu@canonical.com>
References: <1312977952-2272-1-git-send-email-bryan.wu@canonical.com>
	<1312977952-2272-3-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110810130659.GE2680@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

On Wed, Aug 10, 2011 at 08:05:36PM +0800, Bryan Wu wrote:
> Attempting to consolidate the ARM LED code, this removes the
> custom RealView LED trigger code to turn LEDs on and off in
> response to CPU activity and replace it with a standard trigger.
> 
> (bryan.wu at canonical.com:
> It moves arch/arm/kernel/leds.c syscore stubs into this trigger.
> It also provides ledtrig_cpu trigger event stub in <linux/leds.h>.
> Although it was inspired by ARM work, it can be used in other arch.)
> 
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---

This looks really nice and small now!

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
