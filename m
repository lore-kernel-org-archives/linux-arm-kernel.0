From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 11 Jul 2013 18:44:56 +0200
Subject: gpio_blink_set + Kirkwood
In-Reply-To: <51DEDB32.4080101@harsszegi.com>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
 <1a9bcb9094ae695c6707c4835417dd5b@harsszegi.com>
 <20130710073706.GA28212@lunn.ch> <51DEDB32.4080101@harsszegi.com>
Message-ID: <20130711164456.GA3095@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 06:20:02PM +0200, Tibor Harsszegi wrote:
> Hello guys,
> 
> can anyone explain me how does the gpio_blink_set member gets filled
> in leds-gpio through platform_get_drvdata()?
> I can't seem to follow how the specific function pointer can be set
> to orion_gpio_set_blink() for example.
> Sorry for the dumb question :(

Hi Tibor

For DT based board, hardware blinking is not supported, as far as i
remember.

	Andrew
