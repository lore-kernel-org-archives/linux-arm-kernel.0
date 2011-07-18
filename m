From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jul 2011 11:17:51 +0100
Subject: [PATCH 1/3] ARM: S5P64X0: Add HSMMC setup for host Controller
In-Reply-To: <047801cc44f0$4fb16f50$ef144df0$%kim@samsung.com>
References: <1308571049-4412-1-git-send-email-rajeshwari.s@samsung.com>
	<1308571049-4412-2-git-send-email-rajeshwari.s@samsung.com>
	<047801cc44f0$4fb16f50$ef144df0$%kim@samsung.com>
Message-ID: <20110718101751.GU23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 11:13:36AM +0900, Kukjin Kim wrote:
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +
> > +#include <mach/gpio.h>

Please make that linux/gpio.h.
