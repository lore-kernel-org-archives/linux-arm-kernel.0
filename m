From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 1 Jul 2014 14:34:59 +0800
Subject: [PATCH v2 2/2] ARM: imx53: globally disable supervisor protect
In-Reply-To: <20140701063045.GK8053@pengutronix.de>
References: <1403694091-27247-1-git-send-email-s.trumtrar@pengutronix.de>
 <1403694091-27247-2-git-send-email-s.trumtrar@pengutronix.de>
 <20140630041226.GB3329@shlinux2> <20140630070421.GI8053@pengutronix.de>
 <20140701052433.GA14471@dragon> <20140701063045.GK8053@pengutronix.de>
Message-ID: <20140701063458.GC14471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 08:30:45AM +0200, Steffen Trumtrar wrote:
> barebox does it for i.MX6. But it would be better to have it in the kernel,
> so everything works no matter which bootloader is used. AFAIK it is not needed
> for anything the bootloader does.

Okay, sounds reasonable to me.

Shawn
