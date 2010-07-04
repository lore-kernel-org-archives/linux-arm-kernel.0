From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 04 Jul 2010 11:45:40 +0200
Subject: [PATCH 2/3] ASoC: Add SmartQ sound driver
In-Reply-To: <20100704094246.GA2455@opensource.wolfsonmicro.com>
References: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
	<20100704090549.GD16825@opensource.wolfsonmicro.com>
	<4C305229.30409@gmail.com>
	<20100704094246.GA2455@opensource.wolfsonmicro.com>
Message-ID: <4C305844.9000503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 04-07-10 11:42, Mark Brown schreef:
> On Sun, Jul 04, 2010 at 11:19:37AM +0200, Maurus Cuelenaere wrote:
>
>> I don't see what power there is to save? The speaker and headphone
>> jack are connected to the same physical pins, so when disabling the
>> pins for one of them, the other is also disabled.
> Meh, so they are.  That's a slightly unusual design - normally you'd
> wire the speaker amplifier to a separate set of outputs to the
> headphone.

I know, most of the SmartQ design is "slightly unusual"..

-- 
Maurus Cuelenaere
