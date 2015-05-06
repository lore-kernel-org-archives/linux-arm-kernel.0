From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 6 May 2015 11:36:47 +0800
Subject: [rtc-linux] [PATCH v3 3/3] MAINTAINERS: add Mediatek RTC driver
In-Reply-To: <20150505200352.GQ4276@piout.net>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-4-git-send-email-eddie.huang@mediatek.com>
 <20150505200352.GQ4276@piout.net>
Message-ID: <1430883407.28521.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Tue, 2015-05-05 at 22:03 +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 28/04/2015 at 15:35:56 +0800, Eddie Huang wrote :
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2e5bbc0..eb80610 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1223,6 +1223,13 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
> >  S:	Maintained
> >  F:	arch/arm/mach-orion5x/ts78xx-*
> >  
> > +ARM/Mediatek RTC DRIVER
> > +M:	Eddie Huang <eddie.huang@mediatek.com>
> > +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > +L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	drivers/rtc/rtc-mt*
> 
> I feel like this is a bit broad. Unless you want to really maintain
> rtc-mt* which I guess may not be only Mediatek in the future, I would
> use the full filename here. You will probably remember to update it if
> you add more, that may not be the case for other developers.
> 
Yes, you are right, the rtc-mt* is too broad, use full filename is a
better choice right now.

Eddie
