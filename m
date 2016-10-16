From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 16 Oct 2016 18:43:26 +0200
Subject: [PATCH] ARM: at91/dt: pullup dbgu rx instead of tx
In-Reply-To: <6d2d5aba-cca3-93c6-0c59-3acbbd7b6169@lysator.liu.se>
References: <1443105855-15738-1-git-send-email-peda@lysator.liu.se>
 <20150924144753.GY4287@piout.net>
 <6d2d5aba-cca3-93c6-0c59-3acbbd7b6169@lysator.liu.se>
Message-ID: <20161016164326.ep4gjpbeubyfgsjq@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Sun, Oct 16, 2016 at 12:57:09PM +0200, Peter Rosin wrote:
> Hi again,
> 
> I forgot about this, and it's been a year. But isn't it time to
> upstream those pull-up fixes that Sylvain provided?

Thank you for your reminder, actually I waited an answer on this nice 
subject: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/368643.html

But this is not relevant for this change anyway, if we should set a 
pull-(up|down) on all push-pull pads to reduce power consumption it 
should be enforced in the pinctrl driver, the dt must stay logical.

I just sent a v2 with all useless comments removed as suggested by 
Alexandre and without the explanation about the removed extra power 
consumption when removing a pull-(up|down) on a push-pull output because 
it does even seem to be the contrary on Atmel SoCs.

Sylvain
