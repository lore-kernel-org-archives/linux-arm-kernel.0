From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Sep 2011 09:58:56 +0100
Subject: [RFC PATCH 03/11] DT: regulator: Helper routine to extract
	regulator_init_data
In-Reply-To: <4E72F7AB.3030801@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<20110915134427.GJ7988@opensource.wolfsonmicro.com>
	<4E72F7AB.3030801@ti.com>
Message-ID: <20110916085856.GC22062@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 12:45:55PM +0530, Rajendra Nayak wrote:
> On Thursday 15 September 2011 07:14 PM, Mark Brown wrote:
> >On Thu, Sep 15, 2011 at 04:51:59PM +0530, Rajendra Nayak wrote:

> >>+- apply-uV: apply uV constraint if min == max

> >This seems a bit Linux/runtime policy specific (especially the last
> >bit).

> So these bindings should be defined differently?

If at all.
