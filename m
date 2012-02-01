From: stigge@antcom.de (Roland Stigge)
Date: Wed, 01 Feb 2012 14:27:11 +0100
Subject: [PATCH v2 6/7] LPC32xx: clock.c: USB PLL fix
In-Reply-To: <20120131103401.GJ2471@pengutronix.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
 <1327939327-7799-6-git-send-email-stigge@antcom.de>
 <20120131103401.GJ2471@pengutronix.de>
Message-ID: <4F293DAF.4050402@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thanks for reviewing my patches! I collected (and applied) all your
suggestions and will re-post the series as a patch update for applying
to the mainline tree.

On 01/31/2012 11:34 AM, Wolfram Sang wrote:
> I remember we needed that fix back then as well, so I am tempted to
> ack it. However, I'd like to test it but USB is currently not
> available. Do you happen to have a USB fixing commit just to test
> (can be hackish)?

I'm posting this one separately (to be applied on top of all my and
your posted patches).

What do you think about mainline-integrating it?

Thanks in advance!
