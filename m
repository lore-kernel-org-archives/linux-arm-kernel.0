From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 01:03:52 +0000
Subject: [PATCH v2 1/3] regulator: twl: adapt twl-regulator driver to dt
In-Reply-To: <1323771575-3550-2-git-send-email-rnayak@ti.com>
References: <1323771575-3550-1-git-send-email-rnayak@ti.com>
 <1323771575-3550-2-git-send-email-rnayak@ti.com>
Message-ID: <20111220010351.GP2860@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 03:49:33PM +0530, Rajendra Nayak wrote:

I'm OK with this but would prefer that OMAP or TWL people were OK with
it too.  If you do need to respin:

> +For twl4030 regulators/LDO's

' should *not* be used for plurals except when omitting a duplicated s
introduced by one (grammar nit but it really bugs me).
