From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 09:23:55 +0000
Subject: [PATCH v3 2/5] mfd: add bcm590xx pmu driver
In-Reply-To: <20140312005748.GQ25092@beef>
References: <1394552775-31264-1-git-send-email-mporter@linaro.org>
 <1394552775-31264-3-git-send-email-mporter@linaro.org>
 <20140311160837.GP21216@lee--X1> <20140311221938.GO25092@beef>
 <20140311224517.GA5672@lee--X1> <20140311232545.GP25092@beef>
 <20140312004030.GH28112@sirena.org.uk>
 <20140312005748.GQ25092@beef>
Message-ID: <20140312092355.GB5672@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > Are there any inter-patch dependencies in the set? If so, we should
> > > > know about them so we can coordinate a sensible solution.
> > 
> > > Yes, the regulator driver (3/5) that Mark applied is dependent on this
> > > patch...the regulator driver includes include/linux/mfd/bcm590xx.h.
> > 
> > There's no actual dependency though - the regulator driver can only be
> > built if the MFD is enabled in Kconfig since it depends on it so until
> > the MFD is present in the tree it won't get built.
> 
> Oh, right. Lee, no dependencies then.

Perfect, I'll just apply the MFD patch.

We still need the DT guys to look over your document, so nothing will
be certain until a) we receive their Ack or b) enough time passes, so
we will review it between ourselves.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
