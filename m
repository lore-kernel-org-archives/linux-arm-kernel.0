From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 22 Apr 2011 12:56:24 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTikDCmH-WX1u3e9c7gc2U9HJ88RBUQ@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinrtoGhL3CXJZGWzf8+BwFSRsdk0w@mail.gmail.com>
	<BANLkTikDCmH-WX1u3e9c7gc2U9HJ88RBUQ@mail.gmail.com>
Message-ID: <20110422125624.0e2f3a1d@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > There's a couple of things I added on top of what you already seem to have:
> > - in include/linux/of_gpio.h the of_gpio_flags were extended to
> > support open-drain in device-trees.
> 
> Device tree support can very well be handled as an add-on I believe,
> please feel free to do that on top of my patch set :-)

In fact the op code stuff seems to fit very well with device tree as
device tree can now simply attach a list of property/value pairs to an
arbitary GPIO to be fed to it on setup/shutdown/whatever
