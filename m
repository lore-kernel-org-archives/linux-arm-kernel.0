From: laforge@gnumonks.org (Harald Welte)
Date: Thu, 3 Sep 2009 07:30:37 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <873a75pl4z.fsf@macbook.be.48ers.dk>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<873a75pl4z.fsf@macbook.be.48ers.dk>
Message-ID: <20090902223037.GB32606@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Wed, Sep 02, 2009 at 02:49:00PM +0200, Peter Korsgaard wrote:
 
>  Harald> === NAND ===
>  Harald> * mainline currently uses same driver for s3c24xx and s3c64xx
>  Harald> ** samsung uses a new driver for 2450, 6400, 6410 (and later)
>  Harald> * does it make sense to extend the mainline driver with new SoC support
>  Harald>   or should we rather split the mainline driver?
> 
> The nand controllers in the different variants are afaik very similar,
> that's why I added 64xx support to s3c2410.c. What would a split gain
> us?

That's the question the respective developers at Samsung should respond to (see
Cc) Why do you think a split of the nand driver is required? Please comment.

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
