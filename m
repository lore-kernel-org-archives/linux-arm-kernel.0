From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 25 Apr 2010 21:07:42 -0400 (EDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <600365.21352.qm@web35301.mail.mud.yahoo.com>
References: <600365.21352.qm@web35301.mail.mud.yahoo.com>
Message-ID: <alpine.LFD.2.00.1004252105140.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Apr 2010, Allen Pais wrote:

> > >???But currently we are facing issues with test cases such
> > > as AV Playback, mp3 play, image capture, camera 
> > > capture+mpeg4 encode. 
> > > 
> > >???Am not sure what's causing this break, any pointer would be
> > > helpful.
> 
> > To be clear, are you saying that those test cases are failing with 
> > highmem only?
> 
> Yes, when Highmem is enabled, these(testcases) failures
> are what we are observing.

Let's take a simple one: mp3 playback.  What exactly is happening when 
highmem is enabled?


Nicolas
