From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 11:27:21 +0200
Subject: [PATCH v2 0/4] Device Tree updates of UniPhier SoCs for Linux 4.3
In-Reply-To: <CAK7LNAS_Tx=-it9LFg1K7i-URu1Dx_2xnHPkgM1KJkBFb9q4ig@mail.gmail.com>
References: <1438857468-9740-1-git-send-email-yamada.masahiro@socionext.com>
 <20150811132049.GK30181@localhost>
 <CAK7LNAS_Tx=-it9LFg1K7i-URu1Dx_2xnHPkgM1KJkBFb9q4ig@mail.gmail.com>
Message-ID: <20150813092721.GF30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 10:39:47PM +0900, Masahiro Yamada wrote:
> 2015-08-11 22:20 GMT+09:00 Olof Johansson <olof@lixom.net>:
> > On Thu, Aug 06, 2015 at 07:37:44PM +0900, Masahiro Yamada wrote:
> >> Hi Olof and Arnd,
> >>
> >> Here are a little more updates for device trees for UniPhier SoCs.
> >>
> >> Please consider applying this series to your ARM-SOC tree.
> >>
> >> Thanks!
> >
> > Hi,
> >
> > Please always comment on when the previous when you respin. I didn't
> > see this thread until after I had applied v1.
> >
> > I've taken 2/4 directly now, since it's the only difference.
> 
> 
> Instead, build fails between commit a5e921b4771 and 63ef577d9
> because 2/4 is a pre-requisite patch for 3/4 and /4/4.
> 
> 
> Maybe I should have sent a pull-request instead of patches.

The most important thing you should have done is followed up on the bad
patch series. Sending this as a pull request wouldn't have saved you if
you had just sent a second pull request without withdrawing the first one.

Sending patches and pull requests make little different for us for a new
platform with only a few patches per release. We still need to review
your code before we merge it. Actually, doing it as patches is sometimes
a bit easier since we can touch up trivial things instead of asking you
to redo the pull request.


-Olof
