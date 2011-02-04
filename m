From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Feb 2011 19:07:08 -0800
Subject: [PATCH 2/2] ARM: Add empty inituart macros
In-Reply-To: <alpine.LFD.2.00.1102032116091.12104@xanadu.home>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
	<20110204012209.26298.75402.stgit@baageli.muru.com>
	<alpine.LFD.2.00.1102032116091.12104@xanadu.home>
Message-ID: <20110204030708.GR3322@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110203 18:19]:
> On Thu, 3 Feb 2011, Tony Lindgren wrote:
> 
> > Add empty inituart macros. These can be used to initialize
> > the debug serial port based on the machine ID.
...
 
> A better way would be to define the empty inituart macro in a common 
> place, and use the following in the machine specific header file:
> 
> 	.purgem inituart
> 	.macro inituart ...
> 	...
> 	.endm
> 
> This way you won't need to add empty inituart all over the place.

Thanks for the tip, will try that out.

Tony
