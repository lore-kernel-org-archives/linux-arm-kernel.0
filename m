From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 19 Apr 2012 23:23:33 +0200
Subject: [git pull] Renesas DT changes for v3.5
In-Reply-To: <CAOesGMitR0HT7HLCDX9sqohu9iJGPcQp8_TE3oS66ZhfvHizBQ@mail.gmail.com>
References: <201204152320.56147.rjw@sisk.pl>
 <CAOesGMitR0HT7HLCDX9sqohu9iJGPcQp8_TE3oS66ZhfvHizBQ@mail.gmail.com>
Message-ID: <201204192323.33187.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 19, 2012, Olof Johansson wrote:
> Hi Rafael (and Magnus),
> 
> On Sun, Apr 15, 2012 at 2:20 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > Magnus Damm (6):
> >      ARM: mach-shmobile: Introduce shmobile_setup_delay()
> >      ARM: mach-shmobile: Introduce INTC_IRQ_PINS_16H
> >      ARM: mach-shmobile: Use 0x3400 as INTCS vector offset
> >      ARM: mach-shmobile: Use INTC_IRQ_PINS_16H on sh7372
> >      ARM: mach-shmobile: Rework sh7372 INTCS demuxer V2
> >      ARM: mach-shmobile: sh7372 generic board support via DT V2
> 
> I noticed that none of these patches were posted beyond the shmobile
> mailing list.
> 
> We normally wouldn't care as much about patches that change various
> bit twiddling on the SoC specific parts, but for things like device
> tree conversion and bindings, it's useful to get more eyes on the
> changes.
> 
> Can you please cross-post on linux-arm-kernel at lists.infradead.org with
> these kind of platform changes so they get exposed to the wider set of
> readers? Also, once you start doing device bindings, they should be
> cross-posted to devicetree-discuss at lists.ozlabs.org.
> 
> The branch contents looks OK and I'll pull it in, but please start
> doing the above for new patches.

OK, we will.

Thanks,
Rafael
