From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 6 Sep 2010 16:49:45 +0200
Subject: [PATCH v2] atmel_macb Kconfig: remove long dependency line
In-Reply-To: <20100820092653.GJ8693@game.jcrosoft.org>
References: <1281167511-3038-1-git-send-email-plagnioj@jcrosoft.com>
	<1281241293-19571-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTikhx4pVJwKukCfiVWAKyL_BQcdGhhmQvfa+d_xX@mail.gmail.com>
	<20100820092653.GJ8693@game.jcrosoft.org>
Message-ID: <20100906144945.GD26993@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	ping

Best Regards,
J.
On 11:26 Fri 20 Aug     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi,
> 
> 	David is ok with you?
> 
> Best Regards,
> J.
> On 21:42 Tue 10 Aug     , avictor.za at gmail.com wrote:
> > hi Jean-Christophe,
> > 
> > > Many Atmel SOC are embedding a MACB controller. This patch removes the long
> > > dependency line for this Atmel MACB ethernet driver configuration entry.
> > > The HAVE_NET_MACB configuration option is located in the net Kconfig file
> > > as it may be setup by ARM/AT91 and AVR32 chips.
> > 
> > Looks ok from the AT91 point-of-view.
> > 
> > Acked-by: Andrew Victor <linux@maxim.org.za>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
