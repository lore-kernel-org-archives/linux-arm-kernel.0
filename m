From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Apr 2012 23:04:38 +0100
Subject: [PATCH] ARM:mfd: fix ezx-pcap build failure
In-Reply-To: <20120426215258.GG24211@n2100.arm.linux.org.uk>
References: <1335366163-12920-1-git-send-email-mark.asselstine@windriver.com>
 <20120426215258.GG24211@n2100.arm.linux.org.uk>
Message-ID: <20120426220437.GC9415@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 10:52:58PM +0100, Russell King - ARM Linux wrote:

> The real answer is to fix SPI et.al. so that its possible to pass the
> _GPIO_ number into this driver (that's what the driver wants for its
> interrupt line after all).  To fix that, SPI folk need to get involved
> (added Grant as a first step.)

Or, in the short term, add platform data to pass in a GPIO and ignore
any IRQ that might get passed in.
