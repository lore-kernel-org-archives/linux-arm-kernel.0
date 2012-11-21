From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Wed, 21 Nov 2012 10:45:56 +0100
Subject: [PATCH v3 0/3] i2c: at91: add dma support
In-Reply-To: <20121116170514.GA21903@pengutronix.de>
References: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com>
 <20121116170514.GA21903@pengutronix.de>
Message-ID: <50ACA2D4.9040904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Sorry for the delay, I have realized that my answer was not sent 
correctly since I don't see it into the i2c archives.

Le 11/16/2012 06:05 PM, Wolfram Sang a ?crit :
> Hi Ludovic,
>
>> Here is the third version taking into account your feedback.
>
> Thanks, looks mostly good. I have problems applying patch 3. What is
> this series based against?
>

It was based against v3.7-rc4. Do you want me to rebase it against an
over version?

>> Patch 1/3 should go into v3.7.
>
> No, not necessarily. It is not really a bugfix, and it is probably too
> late in the cycle for compiler silencing. Ah well, I decide later.
>
> BTW if you use --strict with checkpatch, it will tell you about the
> space after casts :)
>

Ok, thanks for the tips.

Regards

Ludovic

> Regards,
>
>     Wolfram
>
