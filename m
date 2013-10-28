From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 15:07:41 -0700
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
In-Reply-To: <CACRpkdYANuqDo2V2WfvdN6KNnAb9adU-jdh96ra7RRo2Lvg9xA@mail.gmail.com>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbymhLhHObL+fdWCHKbNG_LtudvhXbdxC0NCJApUBjT9w@mail.gmail.com>
 <201310250006.28668.arnd@arndb.de>
 <CACRpkdYANuqDo2V2WfvdN6KNnAb9adU-jdh96ra7RRo2Lvg9xA@mail.gmail.com>
Message-ID: <20131028220741.GA11660@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 03:53:17PM +0200, Linus Walleij wrote:
> On Fri, Oct 25, 2013 at 12:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 24 October 2013, Linus Walleij wrote:
> >
> >> I would lean toward just applying it and see if the OpenWRT
> >> people will notice and/or complain.
> >>
> >> What does the ARM SoC people say?
> >
> > I'd prefer applying it as-is.
> 
> OK Olof/Kevin: can either of you strip "RFT" from $SUBJECT
> and apply this patch to the ARM SoC tree?

Done, applied to next/cleanup.


-Olof
