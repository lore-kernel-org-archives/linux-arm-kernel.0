From: ben@trinity.fluff.org (Ben Dooks)
Date: Fri, 1 Jun 2012 11:40:10 +0100
Subject: pinctrl: group/pin identity mapping
In-Reply-To: <4FC89437.1070304@parrot.com>
References: <4FC89437.1070304@parrot.com>
Message-ID: <20120601104010.GA26077@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2012 at 12:06:47PM +0200, Gr?gor Boirie wrote:
> Hi All,
> 
> I'm trying to implement pinctrl support for our new cortex based SoC.
> Our driver should provide support for pinctrl/pinmux/pinconf combination
> without device tree handling at the moment.
> However, I'm afraid I misunderstand how groups relate to muxed pins and
> I'd like to hear your suggestions.
> 
> Here's the HW: our I/O pins subsystem allows us to multiplex every
> controllable pins using up to 4 mutually exclusive functions, i.e. there
> is no notion of pin GROUP multiplexing at the HW level (one register per
> pin is available to setup multiplexing and other electronic properties
> like drive strength, pull up/down...).

That sounds very much like how the Samsung system works, you might have
a look at their implementation or get them to give you some feedback on
the approach they took.

I brought this to Linus' attention a couple of times when he was designing
the system originally, so he may also have a good idea of what can be done.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
