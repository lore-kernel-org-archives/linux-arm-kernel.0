From: ptesarik@suse.cz (Petr Tesarik)
Date: Wed, 6 Jun 2018 10:00:24 +0200
Subject: panic kexec broken on ARM64?
In-Reply-To: <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
Message-ID: <20180606100024.50be6b75@ezekiel.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jun 2018 09:02:04 +0200
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Petr,
> 
> Am 05.06.2018 um 19:46 schrieb James Morse:
> > Hi Petr,
> >
> > (CC: +Akashi, Marc)
> >
> > On 05/06/18 09:01, Petr Tesarik wrote:  
> >> I have observed hangs after crash on a Raspberry Pi 3 Model B+ board
> >> when a panic kernel is loaded.  
> > kdump is a best-effort thing, it looks like this is a case where the
> > crashed-kernel can't tear itself down.
> >
> > Do you have the rest of the stack trace? Was it handling an irq when it decided
> > to panic?:
> > https://lkml.org/lkml/2018/3/13/1134  
> 
> the Raspberry Pi 3 B+ support is very fresh (linux-next). Since i didn't 
> see a version, i need to doublecheck.
> 
> You are actually using linux-next and not the downstream kernel?

Very good point. I'll try again with linux-next.

Stay tuned,
Petr T
