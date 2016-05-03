From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 03 May 2016 16:20:42 +0200
Subject: [PATCH 1/7] reset: add devm_reset_controller_register API
In-Reply-To: <CAK7LNAT-fK9zMSov4h8CaG0nbqq=N466zBGFOnZA5LWuxgwDOg@mail.gmail.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
 <1462099023-11819-2-git-send-email-yamada.masahiro@socionext.com>
 <1462270670.3617.49.camel@pengutronix.de>
 <CAK7LNAR699QqYvWdFPtnBc=bLyMLvhCvnKJQCR4YHCy7HQTjUQ@mail.gmail.com>
 <CAK7LNAT-fK9zMSov4h8CaG0nbqq=N466zBGFOnZA5LWuxgwDOg@mail.gmail.com>
Message-ID: <1462285242.3617.74.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 03.05.2016, 20:41 +0900 schrieb Masahiro Yamada:
> 2016-05-03 19:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > 2016-05-03 19:17 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> >> Hi Masahiro,
> >>
> >> Am Sonntag, den 01.05.2016, 19:36 +0900 schrieb Masahiro Yamada:
> >>> Add a device managed API for reset_controller_register().
> >>>
> >>> This helps in reducing code in .remove callbacks and sometimes
> >>> dropping .remove callbacks entirely.
> >>>
> >>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>
> >> Thank you for these patches. Except for the issue with the lpc18xx patch
> >> they all look good to me.
> >> If you don't mind, I'll drop the lpc18xx patch for now and apply the
> >> others.
> >>
> >
> > It is OK with me, but I do not understand what is the problem.
> >
> > Could you answer my question in the 3/7 thread?
>
> Now I am convinced.
> 
> I leave 3/7 to your decision.

Ok, I applied all but 3/7 to my reset/next branch.

thanks
Philipp
