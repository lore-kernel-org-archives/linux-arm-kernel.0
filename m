From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Sep 2013 11:19:35 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1378979431.2627.402.camel@shinybook.infradead.org>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
Message-ID: <20130912101935.GE29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 10:50:31AM +0100, David Woodhouse wrote:

> Conceptually speaking, could it not be an additional argument to
> spi_write_then_read() ? 

Note that spi_write_then_read() is just a helper for building up a spi
transfer in a common pattern.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/aa64cf3c/attachment-0001.sig>
