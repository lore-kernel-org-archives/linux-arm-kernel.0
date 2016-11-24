From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Nov 2016 10:48:58 +0100
Subject: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
In-Reply-To: <8737ihmctr.fsf@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <4031579.CBE32NHUoW@wuerfel> <877f7tmduw.fsf@free-electrons.com>
 <28082657.RK5ubAe11Q@wuerfel> <8737ihmctr.fsf@free-electrons.com>
Message-ID: <20161124104858.3604c11d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 24 Nov 2016 10:44:48 +0100, Gregory CLEMENT wrote:

> "A single Xenon IP can support multiple slots.
> Each slot acts as an independent SDHC. It owns independent resources, such
> as register sets clock and PHY.
> Each slot should have an independent device tree node."

I think this wording is still very confusing, and continues to cause
confusion.

We should just state that each Xenon controller supports a single slot,
and that's it.

The text still says "a single Xenon IP can support multiple slots",
which continues to cause confusion.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
