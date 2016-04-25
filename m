From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 14:59:13 +0200
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <571DCD8D.8070605@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <20160423065431.GA5840@afzalpc> <571DCD8D.8070605@arm.com>
Message-ID: <55296515.n2D97kIgVc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 08:55:57 Vladimir Murzin wrote:
> On 23/04/16 07:54, Afzal Mohammed wrote:
> > Hi,
> > 
> > On Fri, Apr 22, 2016 at 12:43:33PM +0100, Vladimir Murzin wrote:
> > 
> >> Small set of fixes discovered with R-class cores.
> > 
> > just curious, is Cortex-R supported on mainline ?, thought it was not
> > supported, but subject & changelogs gave such a feeling.
> 
> Hi,
> 
> I believe it is supported since c90ad5c "ARM: add Cortex-R7 Processor
> Info" although overtime it got blocked (at least for Vexpress) with
> Kconfig changes. There was attempt [1] to sort it out, but looks like
> these patches went nowhere, so I'm trying to re-start with the fixes
> coming first.
> 
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/174256.html

Good to know, thanks for working on this!

What hardware platform do you use? It would be nice to make it a little
more explicit which platforms can use the ARMv7-R, or an ARMv7-A with
the MMU disabled.

	Arnd
