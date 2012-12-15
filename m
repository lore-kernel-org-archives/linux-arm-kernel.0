From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 15 Dec 2012 01:03:17 +0000
Subject: [PATCH 1/1] spi/atmel: add DT support
In-Reply-To: <20121212151308.GK4398@game.jcrosoft.org>
References: <20121121151713.1F8873E0A47@localhost>
 <1353674679-13158-1-git-send-email-plagnioj@jcrosoft.com>
 <50AF7C19.8000306@atmel.com> <20121212151308.GK4398@game.jcrosoft.org>
Message-ID: <20121215010317.C9C933E0BEC@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Dec 2012 16:13:08 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> On 14:37 Fri 23 Nov     , Nicolas Ferre wrote:
> > On 11/23/2012 01:44 PM, Jean-Christophe PLAGNIOL-VILLARD :
> > > the atmel_spi use only gpio for chip select
> > > 
> > > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > 
> > Seems simple and nice:
> > 
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> grant is ok to have this for 3.8?

Not sure how I missed this one. It's pretty straight forward and not
risky, so no problem. However;

> > > the atmel_spi use only gpio for chip select

I know you know how to write a proper commit message. I'll need
something better than the above before I commit it. I won't make you
resubmit the patch, but do send me a better description.

g.
