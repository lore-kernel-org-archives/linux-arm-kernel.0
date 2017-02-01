From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 1 Feb 2017 17:39:55 +0100
Subject: [PATCH] MAINTAINERS: Add include/dt-bindings/mfd to MFD entry
In-Reply-To: <20170201133006.qpgowrzbwxvgb5ru@dell>
References: <20170201125855.24130-1-lee.jones@linaro.org>
 <20170201130659.GA18081@kroah.com>
 <20170201133006.qpgowrzbwxvgb5ru@dell>
Message-ID: <20170201163955.GB25524@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 01:30:06PM +0000, Lee Jones wrote:
> On Wed, 01 Feb 2017, Greg KH wrote:
> 
> > On Wed, Feb 01, 2017 at 12:58:55PM +0000, Lee Jones wrote:
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 26edd83..17c838a 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8422,6 +8422,7 @@ S:	Supported
> > >  F:	Documentation/devicetree/bindings/mfd/
> > >  F:	drivers/mfd/
> > >  F:	include/linux/mfd/
> > > +F:	include/dt-bindings/mfd/
> > 
> > Why send this to me?  I'm not a MFD maintainer :(
> 
> No, I am. :)

Then you don't need my signed-off-by: for it :)

> But MAINTAINERS doesn't have a supporter and you are the top commit
> signer.  I figured it would be better to get at least one Ack before
> merging my own patch.

I think you just got it from a mfd developer...

thanks,

greg k-h
