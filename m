From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Nov 2012 11:23:42 +0900
Subject: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
In-Reply-To: <5097F078.50701@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com>
 <5097F078.50701@ti.com>
Message-ID: <20121114022341.GM4415@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 05:59:36PM +0100, Benoit Cousson wrote:
> On 11/05/2012 10:42 AM, AnilKumar Ch wrote:

> > +Optional properties:
> > +- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.

> That sounds like a generic functionality to me. Don't we have some more
> generic way to handle that?

> If not, that should probably not be a TI only attribute.

It's pretty unusual to have this configurable as a single thing rather
than as part of flexible power sequencing or something that's just fixed
in silicon.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/dbbb5772/attachment.sig>
