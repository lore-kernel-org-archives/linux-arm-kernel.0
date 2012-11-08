From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Nov 2012 15:32:31 +0000
Subject: [GIT PULL] vexpress: fixes for v3.8
In-Reply-To: <1352387647.20549.10.camel@hornet>
References: <1350580125.4984.23.camel@hornet>
 <201211081405.23202.arnd@arndb.de> <1352387647.20549.10.camel@hornet>
Message-ID: <201211081532.31454.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 November 2012, Pawel Moll wrote:
> On Thu, 2012-11-08 at 14:05 +0000, Arnd Bergmann wrote:
> > diff --git a/arch/arm/include/debug/vexpress.S b/arch/arm/include/debug/vexpress.S
> > index 0c6abbf..dc8e882 100644
> > --- a/arch/arm/include/debug/vexpress.S
> > +++ b/arch/arm/include/debug/vexpress.S
> > @@ -21,6 +21,7 @@
> >  #if defined(CONFIG_DEBUG_VEXPRESS_UART0_DETECT)
> >  
> >               .macro  addruart,rp,rv,tmp
> > +             .arch   armv7-a
> 
> Yes, will you apply it on your side (or fold it into the existing
> change) or do you want me to post a patch (or to update the
> vexpress-fixes branch?)
> 
> Thanks for spotting this!

I've applied it manually now and added you Acked-by.

	Arnd
