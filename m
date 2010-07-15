From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 15 Jul 2010 07:56:11 +0200
Subject: [RFC][PATCH 1/1] ARM: Add initial hibernation support
In-Reply-To: <20100715.083931.226798141.Hiroshi.DOYU@nokia.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<201007150648.50521.marek.vasut@gmail.com>
	<20100715.083931.226798141.Hiroshi.DOYU@nokia.com>
Message-ID: <201007150756.11817.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 15. ?ervence 2010 07:39:31 Hiroshi DOYU napsal(a):
> From: ext Marek Vasut <marek.vasut@gmail.com>
> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> Date: Thu, 15 Jul 2010 06:48:50 +0200
> 
> > Dne St 30. ?ervna 2010 16:28:01 Hiroshi DOYU napsal(a):
> >> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> >> 
> >> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
> >> 
> >> Based on the original work from Romit and Raghu at TI. The original
> >> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
> >> 
> >> *1: https://patchwork.kernel.org/patch/96442/
> >> 
> >> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > 
> > Hey, can this also run on pre-v7 arms ? Or is there something I missed
> > that'd make that impossible?
> 
> What I verified is with OMAP3(Cortex A8) based board.
> 
> cp15 part has to be modified, but it might work without this part itself, I
> guess.

I see ... do I need any special support on the bootloader or userland side ?

Sorry for stupid questions :)
