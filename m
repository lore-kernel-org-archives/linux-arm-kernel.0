From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Tue, 19 Jun 2012 14:00:38 +0200 (CEST)
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <20120619012420.GJ19249@S2101-09.ap.freescale.net>
Message-ID: <1569254394.2932189.1340107238237.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 03:24:22AM +0200, Shawn Guo wrote:
> NAK.
> 
> We have just gone through the pain to clean up those cpu_is_xxx()
> from
> the driver.  Please do not bring them back.

OK. I don't find the changeset you are referring to. Can you give me an example
that tells me by what you replaced those cpu_is_xxx()? By some feature test
macros? E.g., there are still many of those cpu_is_xxx() in
drivers/mtd/nand/mxc_nand.c in linux-next.

Regards,
Beno?t
