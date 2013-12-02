From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 2 Dec 2013 15:25:37 +0100
Subject: [PATCH v6 02/17] dts: mpc512x: introduce dt-bindings/clock/ header
In-Reply-To: <20131202094656.GA12952@e106331-lin.cambridge.arm.com>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-3-git-send-email-gsi@denx.de>
 <20131202094656.GA12952@e106331-lin.cambridge.arm.com>
Message-ID: <20131202142537.GS2982@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 09:46 +0000, Mark Rutland wrote:
> 
> On Sat, Nov 30, 2013 at 10:51:22PM +0000, Gerhard Sittig wrote:
> > introduce a dt-bindings/ header file for MPC512x clocks,
> > providing symbolic identifiers for those SoC clocks which
> > clients will reference from their device tree nodes
> 
> There should be a binding document update to go with this, pointing out
> that this include file defines the set of clock IDs for the MPC512x
> clocks.

It turns out the Freescale MPC512x did not have a separate clocks
binding document, but "just did the usual" and followed the
common bindings.

I've sent a separate doc update patch which becomes applicable
after the CCF implementation got accepted.

> Otherwise, this looks fine to me.

So I take this as a "reviewed by" of yours for this dt-bindings
header file patch, shall I have to re-submit the series.  Thanks!


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
