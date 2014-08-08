From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 8 Aug 2014 22:42:26 +0800
Subject: [PATCH v2 2/4] arm: mediatek: Add support for GIC interrupt
 polarity extension.
In-Reply-To: <CABuKBeL-dcs+pDW3jUeRWNijyYwx4VUdUB=CjGXoGmQUCifQ5Q@mail.gmail.com>
References: <1407505411-2207-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407505411-2207-3-git-send-email-srv_yingjoe.chen@mediatek.com>
 <CABuKBeL-dcs+pDW3jUeRWNijyYwx4VUdUB=CjGXoGmQUCifQ5Q@mail.gmail.com>
Message-ID: <1407508946.4915.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-08-08 at 16:19 +0200, Matthias Brugger wrote:
> 2014-08-08 15:43 GMT+02:00 Joe.C <srv_yingjoe.chen@mediatek.com>:
> > From: "Joe.C" <yingjoe.chen@mediatek.com>
> >
> > Mediatek SoCs have an interrupt polarity extension which allows
> > to swap the polarity for given interrupts.
> 
> Please use ./script/checkpatch.pl, all 4 patches have errors.

Could you send me your result?
I ran checkpatch.pl again on these patches but didn't see any error.

Joe.C
