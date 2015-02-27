From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 27 Feb 2015 12:49:07 -0800
Subject: [PATCH 1/5] serial: atmel: fix error handling when
 mctrl_gpio_init fails
In-Reply-To: <20150227204018.GA8174@pengutronix.de>
References: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150227204018.GA8174@pengutronix.de>
Message-ID: <20150227204907.GA27277@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 09:40:18PM +0100, Uwe Kleine-K?nig wrote:
> Hello Greg,
> 
> probably it's just me being impatient, but I wonder about not getting
> any feedback for the several patches I sent for drivers/tty/serial.
> 
> Are you just not yet in patch-collecting mode for 4.1? Although the
> patches in this series might even be post-merge-window material.

I'm not in a patch-collecting mode for tty/serial drivers for 4.1 just
yet, sorry, I hope to get to them next week.

thanks,

greg k-h
