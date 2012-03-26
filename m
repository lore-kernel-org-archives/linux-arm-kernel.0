From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 26 Mar 2012 06:14:10 +0000
Subject: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
In-Reply-To: <20120323162859.GC24544@arwen.pp.htv.fi>
References: <1332484600-21947-1-git-send-email-afzal@ti.com>
 <4F6C445A.3040103@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317A6A83@DBDE01.ent.ti.com>
 <4F6C9929.6030704@ti.com> <20120323162859.GC24544@arwen.pp.htv.fi>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317BAFCF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Balbi,

On Fri, Mar 23, 2012 at 21:59:00, Balbi, Felipe wrote:
> yeah, I was thinking about drivers/ocd (off-chip devices) or
> drivers/mmio... and that should be flexible enough to hold gpmc, lli and
> c2c (from OMAP's perspective).

Ok, I will check feasibility of having GPMC driver at those places.

> I wouldn't do that. I would only move after the driver is cleaned up.
> Are you concerned with the diffstat alone ? that'd be silly :-p

Ok

Regards
Afzal
