From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 17:51:51 +0200
Subject: [PATCH] ARM: meson6: DTS: Fix wrong reg mapping and IRQ numbers
In-Reply-To: <CAOQ7t2bAQ8RrfssFzAM6m=HGVaQDfcmmqPvmwX4wiAJig9ZVJg@mail.gmail.com>
References: <1443696760-8316-1-git-send-email-carlo@caione.org>
 <CAOQ7t2bAQ8RrfssFzAM6m=HGVaQDfcmmqPvmwX4wiAJig9ZVJg@mail.gmail.com>
Message-ID: <8566547.CSeb89j3FB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 October 2015 11:56:23 Carlo Caione wrote:
> On Thu, Oct 1, 2015 at 12:52 PM, Carlo Caione <carlo@caione.org> wrote:
> > From: Carlo Caione <carlo@endlessm.com>
> >
> > The DTS erronously uses the wrong reg mapping and IRQ numbers for some
> > UART, WDT and timer nodes. Fix this.
> 
> Hi Arnd,
> if you have no complains could you take this into next/dt?
> 
> 

Pulled into next/dt, but please let me know if it should actually go
into 4.3 instead. It looks like a bugfix patch and perhaps also applies
to stable?

	Arnd
