From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 May 2012 09:22:39 +0200
Subject: [PATCH] ARM: mx35: add cpufreq support
In-Reply-To: <20120507141437.GA9636@lovely.krouter>
References: <20120507141437.GA9636@lovely.krouter>
Message-ID: <20120509072239.GG27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 04:14:37PM +0200, Christoph Fritz wrote:
> This patch adds the mx35 to the supported cpu-families of the
> "CPUfreq driver for i.MX CPUs".

I'm afraid this has to wait another cycle since you are patching a file
that is scheduled to be replaced with common clock framework support.

This patch contains several #ifdefs which I think can all be removed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
