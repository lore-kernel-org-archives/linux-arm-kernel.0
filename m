From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Feb 2012 15:31:27 +0000
Subject: [PATCH v3 1/2] regulator: twl: adapt twl-regulator driver to dt
In-Reply-To: <1329996954-27083-2-git-send-email-rnayak@ti.com>
References: <1329996954-27083-1-git-send-email-rnayak@ti.com>
 <1329996954-27083-2-git-send-email-rnayak@ti.com>
Message-ID: <20120223153127.GD4553@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:05:53PM +0530, Rajendra Nayak wrote:
> Modify the twl regulator driver to extract the regulator_init_data from
> device tree when passed, instead of getting it through platform_data
> structures (on non-DT builds)

This doesn't apply to current -next, I expect because of the SMPS
regulator changes which went in.  Please always submit patches against
-next.  There's also a patch from Tero adding support for some
additional regulators which is floating around and would conflict with
this.  Could you guys please coordinate with each other on this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/e2644df1/attachment.sig>
