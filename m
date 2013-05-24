From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 May 2013 19:30:08 +0200
Subject: [GIT PULL] at91: fixes for 3.10 #2
In-Reply-To: <CAOesGMjOaWardKRq-8BM_v8JKx+-Vgzg6XRRL5E1FQTut_ePdQ@mail.gmail.com>
References: <1369410151-7837-1-git-send-email-nicolas.ferre@atmel.com>
 <CAOesGMjvKhVKZf9A70K7VzXikY902KVyKR==4ivnb-gxhyRCPQ@mail.gmail.com>
 <20130524171709.GH24476@game.jcrosoft.org>
 <CAOesGMjOaWardKRq-8BM_v8JKx+-Vgzg6XRRL5E1FQTut_ePdQ@mail.gmail.com>
Message-ID: <20130524173008.GJ24476@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:25 Fri 24 May     , Olof Johansson wrote:
> On Fri, May 24, 2013 at 10:17 AM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 10:11 Fri 24 May     , Olof Johansson wrote:
> >> Hi,
> >>
> >> I'll pull this for now, but...
> >>
> >>
> >> > Jean-Christophe PLAGNIOL-VILLARD (1):
> >> >       ARM: at91: at91sam9n12: move external irq declatation to DT
> >>
> >> This one is not a fix. While OK this time, please stick to only
> >> sending true fixes for 3.10 from here on out.
> >
> > it's as you must specify them via DT, the C code is not event use in case of
> > DT
> > I should have put fix in the commit
> >
> 
> I don't understand.

for DT SoC you must use dt to descrive the external irq on at91 now
the sam9n12 (dt-only soc) was not converted when we did it

this commit fix it

Best Regards,
J.
