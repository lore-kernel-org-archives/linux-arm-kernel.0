From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 17 Mar 2012 21:42:52 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F629D71.3050102@freescale.com>
References: <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
 <4F61F080.4090800@freescale.com>
 <20120315142115.GB6065@S2101-09.ap.freescale.net>
 <4F621D09.2080806@freescale.com>
 <20120316012711.GD6065@S2101-09.ap.freescale.net>
 <4F629D71.3050102@freescale.com>
Message-ID: <20120317214252.GF3315@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 01:55:01AM +0000, Tabi Timur-B04825 wrote:

> I'm just concerned that if there's no standard way to create bindings for 
> machine drivers, we're going to end up with some kind of mess down the road.

I think that we'll be able to deal with that by adding helpers for
common cases (as has already started to happen with some of the nVidia
inspired changes like the auto_nc_pins() stuff) - approach the problem
by extracting the good practice and putting it into helpers to encourage
use.  Fortunately machine drivers are by their nature system specific so
so if they are messed up they impact a limited subset of systems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120317/97ff8154/attachment.sig>
