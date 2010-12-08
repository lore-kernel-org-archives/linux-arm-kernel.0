From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Dec 2010 16:48:29 +0000
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <201012080902.37859.jeremy.kerr@canonical.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>	<201011291559.21928.jeremy.kerr@canonical.com>	<20101207143113.GJ21020@pengutronix.de>
	<201012080902.37859.jeremy.kerr@canonical.com>
Message-ID: <4CFFB6DD.4000108@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/10 01:02, Jeremy Kerr wrote:
> Hi Uwe,
> 
>> I assume the initial feedback should be provided from someone internal
>> to Canonical or Linaro?  Can you give an estimate when you can post it,
>> I really thing that's the way to go for simplifying the clock code on
>> imx which is on my todo list.
> 
> No, I was waiting on feedback from the ST-E platform folks, who will need the 
> atomic clocks. However, I've been out of action for a couple of weeks, hence 
> the delay.

Why do they need atomic clocks?

This is starting to look like a real mess.
