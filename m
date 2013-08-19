From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 19 Aug 2013 23:16:20 +0200
Subject: [PATCH RESEND] i2c: move of helpers into the core
In-Reply-To: <20130819194603.GC4961@mithrandir>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
 <20130819194603.GC4961@mithrandir>
Message-ID: <20130819211620.GA13092@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 09:46:04PM +0200, Thierry Reding wrote:
> On Mon, Aug 19, 2013 at 07:59:40PM +0200, Wolfram Sang wrote:
> [...]
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> [...]
> > +#if IS_ENABLED(CONFIG_OF)
> > +static void of_i2c_register_devices(struct i2c_adapter *adap)
> > +{
> [...]
> > +}
> [...]
> > +#endif /* CONFIG_OF */
> 
> Isn't this missing the dummy implementation for !OF.

Argh, will fix...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130819/61012926/attachment.sig>
