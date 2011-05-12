From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2011 02:40:01 -0700
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <20110512074421.GA2429@pengutronix.de>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110512074421.GA2429@pengutronix.de>
Message-ID: <20110512094001.GH31483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sascha Hauer <s.hauer@pengutronix.de> [110512 00:40]:
> 
> These all basically describe the same thing: put pad x into one of modes
> a, b, c and apply certain flags like drive strength on this.
> 
> the other class of pin muxing I know of is that a whole group of pads
> can be switched to a particular mode using a mux register like I think
> is used used in your ux300 driver.
> 
> I'd like to have a unified way to describe this. If we ever want to move
> this into the device tree we need this anyway as I think it's not an
> option to have completely different SoC specific descriptions in the
> device tree.

Me too. Otherwise we'll have multiple different device tree implementations.

We might as well have the data in suitable format for device tree to
start with, and then have common access functions that can be replaced
for various platforms if necessary.

Regards,

Tony
