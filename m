From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 17:58:36 +0100
Subject: [PATCH 5/6] csb1724: Enable device tree based mv643xx ethernet
 support.
In-Reply-To: <20120730155547.GL18016@lunn.ch>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-6-git-send-email-ian.molton@codethink.co.uk>
 <20120730155547.GL18016@lunn.ch>
Message-ID: <5016BD3C.2060205@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 16:55, Andrew Lunn wrote:
> On Mon, Jul 30, 2012 at 04:15:58PM +0100, Ian Molton wrote:

> Hi Ian
>
> I'm trying to keep this in order. Currently i2c is in the wrong
> place, but the rest are incremental. It looks like these should be
> between wdt & sata.

Will fix.

> What about default entries for egiga0 and egiga1 with status
> "disabled"? It looks like the only thing which changes between
> boards is phy_addr.

Seems sensible. I'll change that for v2.

-Ian
