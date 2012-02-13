From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 13 Feb 2012 03:41:39 +0100
Subject: [PATCH V3] MTD: atmel_nand: Update driver to support
 Programmable HW ECC controller
In-Reply-To: <1328959692.22240.103.camel@sauron.fi.intel.com>
References: <1328491977-30448-1-git-send-email-hong.xu@atmel.com>
 <1328959692.22240.103.camel@sauron.fi.intel.com>
Message-ID: <20120213024139.GA3378@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:28 Sat 11 Feb     , Artem Bityutskiy wrote:
> On Mon, 2012-02-06 at 09:32 +0800, Hong Xu wrote:
> > +static int16_t *pmecc_get_index_of(struct atmel_nand_host *host)
> > +{
> > +       int16_t *p = (int16_t *)host->rom_base;
this need to be passed via resource

Best Regards,
J.
