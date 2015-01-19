From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Jan 2015 15:55:58 -0600
Subject: [PATCH] MAINTAINERS: add omap2plus_defconfig under OMAP SUPPORT
In-Reply-To: <CABxcv=keBgUme5mrNKg_h_h1WZHsaz4QOOyEPLa3XJYaEPE0Jw@mail.gmail.com>
References: <1421703901-28295-1-git-send-email-balbi@ti.com>
 <CABxcv=keBgUme5mrNKg_h_h1WZHsaz4QOOyEPLa3XJYaEPE0Jw@mail.gmail.com>
Message-ID: <20150119215558.GW20386@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 10:52:56PM +0100, Javier Martinez Canillas wrote:
> Hello Felipe,
> 
> On Mon, Jan 19, 2015 at 10:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> > omap2plus_defconfig is also part of the OMAP Support
> > maintained, because of that it's best to list it
> > under OMAP SUPPORT on MAINTAINERS so people know
> > to Cc linux-omap when patching that file.
> >
> > Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 97de006f38f0..abc6281892e7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6783,6 +6783,7 @@ Q:        http://patchwork.kernel.org/project/linux-omap/list/
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> >  S:     Maintained
> >  F:     arch/arm/*omap*/
> > +F:     arch/arm/configs/omap2plus_defconfig
> 
> While been there, could you please also add omap1_defconfig?

Sure, Tony, is that ok ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/8b066afa/attachment.sig>
