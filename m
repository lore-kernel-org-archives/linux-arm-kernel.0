From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Tue, 10 Aug 2010 21:42:46 +0200
Subject: [PATCH v2] atmel_macb Kconfig: remove long dependency line
In-Reply-To: <1281241293-19571-1-git-send-email-plagnioj@jcrosoft.com>
References: <1281167511-3038-1-git-send-email-plagnioj@jcrosoft.com>
	<1281241293-19571-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <AANLkTikhx4pVJwKukCfiVWAKyL_BQcdGhhmQvfa+d_xX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Jean-Christophe,

> Many Atmel SOC are embedding a MACB controller. This patch removes the long
> dependency line for this Atmel MACB ethernet driver configuration entry.
> The HAVE_NET_MACB configuration option is located in the net Kconfig file
> as it may be setup by ARM/AT91 and AVR32 chips.

Looks ok from the AT91 point-of-view.

Acked-by: Andrew Victor <linux@maxim.org.za>
