From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Dec 2010 12:15:51 -0800
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <20101223195503.GN7771@atomide.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<20101223195503.GN7771@atomide.com>
Message-ID: <20101223201551.GP7771@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101223 12:01]:
> 
> Looks like the long term solution is to move the _user_swpX_asm
> into a separate .S file and set the v7 instructions for it.

I mean set the v7 compiler flags for it..

Tony
