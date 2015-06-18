From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 18 Jun 2015 09:54:50 +0200
Subject: [PATCH] clk: at91: add generated clock driver
In-Reply-To: <55827606.7020908@atmel.com>
References: <1434547409-12232-1-git-send-email-nicolas.ferre@atmel.com>
 <1434611556.2385.8.camel@x220> <20150618093344.7d486e97@bbrezillon>
 <55827606.7020908@atmel.com>
Message-ID: <1434614090.2385.19.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, 2015-06-18 at 09:40 +0200, Nicolas Ferre wrote:
> I am in the process, with my colleagues, of building bricks for our
> upcoming SoC the sama5d2. So, the basic support for this chip will come
> in the next weeks and will select this Kconfig option.

Perhaps that could be added, say below the --- marker in the patch.
Maybe I missed something to that effect. Anyhow, I didn't spot in the
patch that this was done deliberately. It had all the looks of a silly
mistake.

> I'd like though that this matter of fact doesn't block this piece of
> code from being reviewed or even better merged in order to ease this new
> SoC landing...

The other side of that is that the sama5d2 might never make it, or take
very long to make it, into mainline. And this would then end up being
yet another chunk of code adding no value to mainline.

Thanks,


Paul Bolle
