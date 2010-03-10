From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 10 Mar 2010 14:35:29 +0100
Subject: [PATCH] Voipac PXA270
In-Reply-To: <201003101237.26819.marek.vasut@gmail.com>
References: <201003100247.27059.marek.vasut@gmail.com>
	<4B9739C0.2090805@compulab.co.il>
	<201003101237.26819.marek.vasut@gmail.com>
Message-ID: <20100310133529.GK28972@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 12:37:26PM +0100, Marek Vasut wrote:
> Dne St 10. b?ezna 2010 07:18:40 Mike Rapoport napsal(a):
> > Do these defines really deserve dedicated .h file? Why cannot they live
> > in the arch/arm/mach-pxa/vpac270.c?
> 
> I'm not moving this in. I dont want to polute the .c file with stuff that should 
> obviously go into the header file. Besides there'll be more GPIOs defined and 
> that'd make the .c file less readable, which I want to avoid.

The question is - are they shared? If they're not and will never be used
by anything else then this .c file, I'd also vote for not having an
extra header file for them.

Daniel
