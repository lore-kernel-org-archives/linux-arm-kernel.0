From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Sep 2013 14:50:32 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <52284F32.2020302@freescale.com>
References: <20130904113322.GA5859@sirena.org.uk>
 <20130905014350.GA2261@gmail.com>
 <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C885@DBDE04.ent.ti.com>
 <5228369A.9000904@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C907@DBDE04.ent.ti.com>
 <52284F32.2020302@freescale.com>
Message-ID: <20130905135032.GB3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 05:30:26PM +0800, Huang Shijie wrote:
> ? 2013?09?05? 17:11, Gupta, Pekon ??:

> >Anyway, if you really want to continue with this is, then please re-name
> >include/linux/mtd/spi-nor.h to
> >include/linux/mtd/spi-fsl-quadspi.h
> >because something specific for your driver should not conflict with
> >generic spi-nor framework added later.

> i think there is no specific thing for this driver. The S25FL128S is
> a common flash,
> other person may uses it too. Could you show me what is specific?

> so, i prefer to spi-nor.h.

Looking at the current header there just seem to be defines in there, no
abstraction for the chips.  Perhaps that is what is missing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130905/cddc4fba/attachment.sig>
