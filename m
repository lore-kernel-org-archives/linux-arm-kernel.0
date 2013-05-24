From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 May 2013 19:17:09 +0200
Subject: [GIT PULL] at91: fixes for 3.10 #2
In-Reply-To: <CAOesGMjvKhVKZf9A70K7VzXikY902KVyKR==4ivnb-gxhyRCPQ@mail.gmail.com>
References: <1369410151-7837-1-git-send-email-nicolas.ferre@atmel.com>
 <CAOesGMjvKhVKZf9A70K7VzXikY902KVyKR==4ivnb-gxhyRCPQ@mail.gmail.com>
Message-ID: <20130524171709.GH24476@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:11 Fri 24 May     , Olof Johansson wrote:
> Hi,
> 
> I'll pull this for now, but...
> 
> 
> > Jean-Christophe PLAGNIOL-VILLARD (1):
> >       ARM: at91: at91sam9n12: move external irq declatation to DT
> 
> This one is not a fix. While OK this time, please stick to only
> sending true fixes for 3.10 from here on out.

it's as you must specify them via DT, the C code is not event use in case of
DT
I should have put fix in the commit

Best Regards,
J.
> 
> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
