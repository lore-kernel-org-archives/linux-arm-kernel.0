From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 14 Jun 2014 21:01:59 +0200
Subject: device tree: compilation of device tree sources
In-Reply-To: <539AE266.70306@cdac.in>
References: <539AE266.70306@cdac.in>
Message-ID: <20140614190159.GF15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 05:07:10PM +0530, Varka Bhadram wrote:
> Hi,
> 
> I cloned the device tree git from: https://kernel.googlesource.com/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing
> 
> When i try to compile the Makefile is throwing errors like this:
> 
> DTC     src/arc/abilis_tb100_dvk.dtb
> 
> dtc: invalid option -- 'i'

Your dtc version is too old. Please upgrade.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
