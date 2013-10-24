From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Oct 2013 00:06:26 +0200
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
In-Reply-To: <CACRpkdbymhLhHObL+fdWCHKbNG_LtudvhXbdxC0NCJApUBjT9w@mail.gmail.com>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbymhLhHObL+fdWCHKbNG_LtudvhXbdxC0NCJApUBjT9w@mail.gmail.com>
Message-ID: <201310250006.28668.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 October 2013, Linus Walleij wrote:

> > This is flagged as Request for Testing (RFT) as I have no Gemini
> > platform. If I do not get help with testing this, the next step
> > will be a patch series to delete the platform.
> 
> OK nobody is able to test this it seems, but it is a vital refactoring.
> 
> Should we just apply this and see what happens?
> 
> Or should I just send a deletion patch right away?
> 
> I would lean toward just applying it and see if the OpenWRT
> people will notice and/or complain.
> 
> What does the ARM SoC people say?

I'd prefer applying it as-is.

	Arnd
