From: r.sricharan@ti.com (R, Sricharan)
Date: Wed, 4 Jul 2012 20:55:49 +0530
Subject: [PATCH 2/4] ARM: OMAP2+: Move the stubbed prm and cm functions to
 prcm.c file and make them __weak.
In-Reply-To: <alpine.DEB.2.00.1207040431400.6760@utopia.booyaka.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
 <1336669615-16454-3-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com>
 <CAJ7qFSdiMgM3S5Q+XaFAGrgcL5M5f8CLHyKSRtBKu4AK6ei-BA@mail.gmail.com>
 <CAJ7qFSfu3yyj8YqETTzx+wipi1Nbf5m5fDLC26Tfojav+Lb56Q@mail.gmail.com>
 <alpine.DEB.2.00.1207040431400.6760@utopia.booyaka.com>
Message-ID: <CAJ7qFSc7qNJ91J9sbsYFA5TW=qvyyDXkoL+XuTkHxvFrqBLqkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
On Wed, Jul 4, 2012 at 8:49 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 28 Jun 2012, R, Sricharan wrote:
>
>>  Ping..
>
> Since the prcm.c cleanup series isn't ready yet, I've queued this modified
> version of your patch.
>
> Once the prcm.c cleanup series is ready, hopefully in the 3.7 time frame,
> we'll be able to get rid of all of these nasty stubs.
>
 Thanks a lot. I think this should help to get rid of the OMAP5 dependency.

Thanks,
 Sricharan
