From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Feb 2012 12:53:06 +0100
Subject: [PATCH 5/6 V2] atmel/nand: add DT support
In-Reply-To: <4F30FD4B.4050501@atmel.com>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
 <1328524512-18159-2-git-send-email-plagnioj@jcrosoft.com>
 <4F30FD4B.4050501@atmel.com>
Message-ID: <20120207115306.GF15647@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:30 Tue 07 Feb     , Nicolas Ferre wrote:
> On 02/06/2012 11:35 AM, Jean-Christophe PLAGNIOL-VILLARD :
> > use a local copy of board informatin and fill with DT data
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Cc: linux-mtd at lists.infradead.org
> 
> [..]
> 
> > +static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
> > +					 struct device_node *np)
> 
> Maybe you will need to protect this function in case of !DT builds: I
> suspect that some of the of_xxxxx() calls are not provided if !CONFIG_OF.
no-need on the of_ function are static inline it !CONFIG_OF

Best Regards,
J.
