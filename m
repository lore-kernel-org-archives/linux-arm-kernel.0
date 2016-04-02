From: plaes@plaes.org (Priit Laes)
Date: Sat, 02 Apr 2016 17:42:00 +0300
Subject: [linux-sunxi] Re: [PATCH 3/3] sunxi: A20-OLinuXino-LIME2: Add
 i2c2 bus in DTS
In-Reply-To: <20160402103420.GH4227@lukather>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <1458932647-24268-3-git-send-email-haas@computerlinguist.org>
 <20160402103420.GH4227@lukather>
Message-ID: <1459608120.29592.3.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-04-02 at 12:34 +0200, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Mar 25, 2016 at 08:04:07PM +0100, Michael Haas wrote:
> > 
> > The A20 processor provides a third I2C bus on pins PB20 and PB21.
> > The A20-OLinuXino-LIME2 exposes this bus via its GPIO1 port.
> > 
> > Olimex also provide a breakout board called the
> > A20-OLinuXino-LIME2-UEXT. This change is required to properly
> > support I2C on the UEXT connector found there.

Documentation for Olimex UEXT interface:
https://www.olimex.com/Products/Modules/UEXT/resources/UEXT_rev_B.pdf

Basically it *should* by default work as a board to board connector
which supports three serial communication interfaces: I2C, SPI and UART
(original document mentions RS232, but official modules work only with
3.3V logic levels).

> > 
> > Signed-off-by: Michael Haas <haas@computerlinguist.org>
> What are the other options on that pin? Is it something exclusively
> dedicated to i2c on the pin headers and the documentation, or is
> anyone free to use that pin for whatever he wishes?
> 
> Thanks,
> Maxime
> 
> --?
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> 
