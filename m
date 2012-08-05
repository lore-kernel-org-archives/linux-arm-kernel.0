From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 5 Aug 2012 10:39:26 +0200
Subject: [PATCH] mtd: mxc_nand: Fix compiler warnings
In-Reply-To: <501D4405.6030900@googlemail.com>
References: <1343466310-14584-1-git-send-email-dirk.behme@gmail.com>
 <20120730073454.GI1528@pengutronix.de>
 <501D4405.6030900@googlemail.com>
Message-ID: <20120805083926.GL2626@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 04, 2012 at 05:47:17PM +0200, Dirk Behme wrote:
> On 30.07.2012 09:34, Uwe Kleine-K?nig wrote:
> >Hello,
> >
> >On Sat, Jul 28, 2012 at 11:05:10AM +0200, Dirk Behme wrote:
> >>From: Dirk Behme<dirk.behme@googlemail.com>
> >>
> >>Fix the compiler warnings
> >>
> >>drivers/mtd/nand/mxc_nand.c:1267: warning: initialization discards qualifiers from pointer target type
> >>drivers/mtd/nand/mxc_nand.c:1270: warning: initialization discards qualifiers from pointer target type
> >>drivers/mtd/nand/mxc_nand.c:1273: warning: initialization discards qualifiers from pointer target type
> >>drivers/mtd/nand/mxc_nand.c:1276: warning: initialization discards qualifiers from pointer target type
> >These should be gone in next already.
> 
> Hmm, which next?
> 
> I tried linux-next [1] from today (next-20120803, 55fa9961f) and still get
next-20120725 contained 98d7bbb9929bcc14e11ac8a55245a4f2dc174e17, don't
konw why it isn't included in the newer next snapshorts.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
