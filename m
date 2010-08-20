From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 20 Aug 2010 11:26:53 +0200
Subject: [PATCH v2] atmel_macb Kconfig: remove long dependency line
In-Reply-To: <AANLkTikhx4pVJwKukCfiVWAKyL_BQcdGhhmQvfa+d_xX@mail.gmail.com>
References: <1281167511-3038-1-git-send-email-plagnioj@jcrosoft.com>
	<1281241293-19571-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTikhx4pVJwKukCfiVWAKyL_BQcdGhhmQvfa+d_xX@mail.gmail.com>
Message-ID: <20100820092653.GJ8693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	David is ok with you?

Best Regards,
J.
On 21:42 Tue 10 Aug     , avictor.za at gmail.com wrote:
> hi Jean-Christophe,
> 
> > Many Atmel SOC are embedding a MACB controller. This patch removes the long
> > dependency line for this Atmel MACB ethernet driver configuration entry.
> > The HAVE_NET_MACB configuration option is located in the net Kconfig file
> > as it may be setup by ARM/AT91 and AVR32 chips.
> 
> Looks ok from the AT91 point-of-view.
> 
> Acked-by: Andrew Victor <linux@maxim.org.za>
