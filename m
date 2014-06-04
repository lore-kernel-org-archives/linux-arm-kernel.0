From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 04 Jun 2014 21:40:09 +0200
Subject: [alsa-devel] [PATCH] ASoC: pxa: add I2C dependencies as needed
In-Reply-To: <20140603215944.GB2520@sirena.org.uk> (Mark Brown's message of
 "Tue, 3 Jun 2014 22:59:44 +0100")
References: <46560700.2S4p0nUZl8@wuerfel> <87k38xg0k6.fsf@free.fr>
 <20140603215944.GB2520@sirena.org.uk>
Message-ID: <87fvjkfopy.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

>> Any reason SND_PXA2XX_SOC_MIOA701 escaped ? The board is PXA based, and its
>> codec wm9713 is I2C based, and relies on AC97.
>
> The WM9713 is AC'97 only, there's no I2C interface there.
Gees, you're right. I was remembering the registers, and that made my think of
I2C registers, like in Maxim regulators.

My bad, you're right, no I2C.

Cheers.

-- 
Robert
