From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 09 Mar 2015 22:12:32 +0100
Subject: [PATCH v2 04/18] clocksource: Add ARM System timer driver
In-Reply-To: <CALszF6AEThPrRe7c7nJ6q7yb2fhLMFuHJUV10sf=w0TMcqVVaw@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
 <20150220195437.GT19388@pengutronix.de> <1424468908.24292.10.camel@x220>
 <CALszF6Bm_Y4ZLednjpmP-hMix3gA23FwLm5hViEjr1QojUY+Mg@mail.gmail.com>
 <1425411786.2606.24.camel@tiscali.nl>
 <CALszF6AEThPrRe7c7nJ6q7yb2fhLMFuHJUV10sf=w0TMcqVVaw@mail.gmail.com>
Message-ID: <1425935552.4244.6.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-03-04 at 13:08 +0100, Maxime Coquelin wrote:
> This is because I added also support for COMPILE_TEST coverage as per
> Uwe advice,
> and thought it was necessary to have an entry for this.
> Maybe I'm just wrong?

I missed that you added COMPILE_TEST.

A quick scan of your idea doesn't show any obvious issues. (Note that I
don't really know how people actually use COMPILE_TEST. I guess things
like "make allyesconfig" are involved.)


Paul Bolle
