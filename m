From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 18 Jun 2015 16:46:46 +0200
Subject: [PATCH] clk: at91: add generated clock driver
In-Reply-To: <5582BC50.1050801@atmel.com>
References: <1434547409-12232-1-git-send-email-nicolas.ferre@atmel.com>
 <1434611556.2385.8.camel@x220> <20150618093344.7d486e97@bbrezillon>
 <55827606.7020908@atmel.com> <1434614090.2385.19.camel@x220>
 <5582BC50.1050801@atmel.com>
Message-ID: <1434638806.2385.91.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, 2015-06-18 at 14:40 +0200, Nicolas Ferre wrote:
> I have several options here:
> 
> 1/ I send the clock patch early and benefit from early review and a
> comfortable landing strip
> 
> 2/ I send the SoC early and have the very same remark concerning the
> "+       select HAVE_AT91_GENERATED" line in my patch

(In that case that line could be part of the patch adding the clock
driver. That might work too. Depends on how things fit together,
obviously.)

> 3/ I do it in several separated series... but at the price of additional
> synchronization between subsystems, additional dumb patches with so
> little benefit in my opinion.

Would one series for everything you plan to submit have worked here or
would that grow unwieldy?

Anyhow, would I have known that the code that actually enables this
driver to build was pending this discussion would not have started. (I
do try to check for related patches, on lkml that is, even if they're
not part of the same series etc.) Say, with a small remark below the ---
line as we discussed. And would I then have started a thread like this
you could point a finger at me and shout: "Paul can't read! Na na na na
na! Paul can't read!"

> Ok, so I post sama5d2 early support today so that we can agree it's not
> necessary to add superfluous steps.

I see.

Thanks,


Paul Bolle
