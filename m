From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 09:21:15 +0200
Subject: [PATCH 00/58] ARM: at91: rework Atmel TCB drivers
In-Reply-To: <da7069d4-e5b3-f10f-0816-ff973195aff6@axentia.se>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <da7069d4-e5b3-f10f-0816-ff973195aff6@axentia.se>
Message-ID: <20170531072115.apeyzsqmfxa2qnd6@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31/05/2017 at 08:34:00 +0200, Peter Rosin wrote:
> On 2017-05-30 23:50, Alexandre Belloni wrote:
> > Hi,
> > 
> > This series reworks the Atmel Timer counter Block drivers. Those blocks
> > each have 3 counters with 2 channels each and can be used for
> > multiple functions:
> >  - timers
> >  - PWMs
> >  - Quadrature decoders
> >  - Stepper motor counters
> 
> I'd like to test this, but I have a hard time doing that since all I got
> was this cover letter and a single DT-only patch.
> 
> I understand that you were reluctant to spam too many people with
> dozens of patches, but perhaps the series can be fetched from
> somewhere?
> 

Sure, I've pushed the branch here:
https://github.com/alexandrebelloni/linux/tree/at91-tcb-v3

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
