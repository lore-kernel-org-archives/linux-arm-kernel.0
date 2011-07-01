From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Jul 2011 00:30:20 -0700
Subject: [PATCH] ARM: OMAP: Overo: remove duplicate call to
	overo_ads7846_init()
In-Reply-To: <87lix0b2dr.fsf@ti.com>
References: <87r56sbg3b.fsf@ti.com>
	<1308327432-31177-1-git-send-email-zonque@gmail.com>
	<87lix0b2dr.fsf@ti.com>
Message-ID: <20110701073020.GE23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110617 13:54]:
> Daniel Mack <zonque@gmail.com> writes:
> 
> > overo_ads7846_init() is already called from overo_spi_init(), and
> > calling it twice is not only unnecessary but causes a warning as
> > "reg-fixed-voltage.1" is already added to the device tree.
> 
> Excellent, thanks!
> 
> > Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> Tested-by: Kevin Hilman <khilman@ti.com>
> 

Applying into devel-fixes.

Tony
