From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 15:56:51 +0800
Subject: [PATCH v3 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA56C5B@DBDE04.ent.ti.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
 <20131217040209.GA27091@shlinux2.ap.freescale.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA56B3A@DBDE04.ent.ti.com>
 <20131217060731.GJ6691@S2101-09.ap.freescale.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA56C5B@DBDE04.ent.ti.com>
Message-ID: <20131217075649.GL6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 07:17:01AM +0000, Gupta, Pekon wrote:
> All I said was using company names in Headers or MODULE_AUTHOR of
> *generic frameworks*. A generic framework is maintained and updated
> by community at large. And over course of time other people contribute
> more than the author. So tagging a company name there would sound like
> _repeatedly_ giving credit to company or yourself, even if most of the
> original  code is changed now. Does that make sense ?

I could somehow buy in the argument of using person email over company
one in MODULE_AUTHOR(), but still not the one that do not use company
name in Headers.

In this case, Huang works for Freescale and Freescale pays him to do the
work, so Huang shares the authorship and Freescale shares the copyright.
There is nothing wrong adding Freescale copyright into the file header,
based on my understanding.  When other people make significant changes
and contributions to the file, they are welcomed to add more copyright
info on top of the existing ones.

I'm not a lawyer, and more than happy to be corrected if I'm wrong.

Shawn
