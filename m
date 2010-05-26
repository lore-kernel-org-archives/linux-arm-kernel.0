From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 27 May 2010 07:38:46 +1000
Subject: [PATCH 5/5] leds-gpio: Change blink_set callback to be able to
	turn off blinking
In-Reply-To: <1274874250.16229.87.camel@rex>
References: <1274525695.1931.143.camel@pasglop>
	<1274871937.16229.79.camel@rex>  <1274872808.1931.310.camel@pasglop>
	<1274874250.16229.87.camel@rex>
Message-ID: <1274909926.1931.331.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-26 at 12:44 +0100, Richard Purdie wrote:
> Yes, I noticed just after I hit send and applied. I'd rather get the
> core change in sooner than later and the reject doesn't look serious
> so
> I'm assuming you can fix up the missing active_low bit for the new
> addition easily enough? 

Yup. No big deal.

Cheers,
Ben.
