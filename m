From: stigge@antcom.de (Roland Stigge)
Date: Tue, 24 Jan 2012 17:32:21 +0100
Subject: [PATCH] Correct bad gpio naming
In-Reply-To: <20120124155921.GH2609@pengutronix.de>
References: <4F1C4E25.6070801@antcom.de> <20120124155921.GH2609@pengutronix.de>
Message-ID: <4F1EDD15.7010704@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/24/2012 04:59 PM, Wolfram Sang wrote:
> On Sun, Jan 22, 2012 at 06:57:57PM +0100, Roland Stigge wrote:
>> One of the GPIO names in drivers/gpio/gpio-lpc32xx.c was bad.
>> Renaming gpi000 -> gpio00
>> 
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> Since you are modifying LPC32xx :) Which kernel version do you run?
> I was trying to get a board up with 3.0 (not booting) and 3.3-rc1
> (build breakage). I even thought about removing that mach, since
> vital parts seem to be missing (Net, NAND) or broken. So, I am
> interested if there are still users.

I'm actively maintaining an LPC32xx machine line (WORK Microwave GmbH
devices) at http://git.antcom.de/ - feel free to merge from there.

For me, it works fine with Linux 3.2.0.

The repo includes some additional features like NAND (esp. MLC
controller, while NXP implemented an SLC driver), High Speed UARTs and
ADC. Some of those are not yet integrated mainline, but I'm willing to
help here. Looks like I will maintain it anyway for the next few years.

Expect the first one of the drivers to be submitted soon, I will do
them one by one.

Thanks for keeping LPC32xx :-)

Roland
