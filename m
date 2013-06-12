From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 17:20:05 -0700
Subject: [PATCH 3/6] ARM: SAMSUNG: pm: Adjust for pinctrl- and DT-enabled
 platforms
In-Reply-To: <1904605.joOAnPJ6dR@flatron>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <20130611074552.GK6688@quad.lixom.net>
 <CAOesGMgjnt+T1OEFy15J0-zkHwHyeo3XLyzTGqmozq-t0nm=GQ@mail.gmail.com>
 <1904605.joOAnPJ6dR@flatron>
Message-ID: <CAOesGMh1aeiQfiEAd7xx_PmyZq1fC8y2pxjAVABHLmE7ECkEtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 5:15 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

>> > Please do follow through with the promised cleanups
>> > at some point, Tomasz. :-)
>
> Yeah, just managed to reserve some time for it, so stay tuned ;) .

Cool.

>> Btw, I had to add an include of <linux/of.h> or else all non-DT builds
>> broke...
>
> Sorry, I must have missed it.
>
> I guess it's the right time to set up some autobuild framework to check
> all patches with several most interesting configs. I guess some git hooks
> would be enough...

No worries. I tend to build all defconfigs after doing a batch of
pulls, and that's when we find these issues. I also boot on the few
boards that I have to make sure nothing catastrophic is broken, but
there's obviously much less coverage on that side.


-Olof
