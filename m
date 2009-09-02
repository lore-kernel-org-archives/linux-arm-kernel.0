From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 02 Sep 2009 14:49:00 +0200
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902031719.GK3838@prithivi.gnumonks.org> (Harald Welte's
	message of "Wed\, 2 Sep 2009 12\:17\:19 +0900")
References: <20090902031719.GK3838@prithivi.gnumonks.org>
Message-ID: <873a75pl4z.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Harald" == Harald Welte <laforge@gnumonks.org> writes:

Hi,

 Harald> === NAND ===
 Harald> * mainline currently uses same driver for s3c24xx and s3c64xx
 Harald> ** samsung uses a new driver for 2450, 6400, 6410 (and later)
 Harald> * does it make sense to extend the mainline driver with new SoC support
 Harald>   or should we rather split the mainline driver?

The nand controllers in the different variants are afaik very similar,
that's why I added 64xx support to s3c2410.c. What would a split gain
us?

-- 
Bye, Peter Korsgaard
