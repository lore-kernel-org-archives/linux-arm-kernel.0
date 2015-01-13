From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 13 Jan 2015 23:15:54 +0800
Subject: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C
 controller
In-Reply-To: <20150113095725.GC1059@katana>
References: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
 <20141124121555.GG3733@katana> <1417096856.12707.59.camel@mtksdaap41>
 <20141127164536.GC5667@katana> <1418352022.4994.44.camel@mtksdaap41>
 <20150106133753.GA3754@katana>  <20150113095725.GC1059@katana>
Message-ID: <1421162154.27675.75.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-13 at 10:57 +0100, Wolfram Sang wrote:
> On Tue, Jan 06, 2015 at 02:37:53PM +0100, Wolfram Sang wrote:
> > 
> > > We've started upstream work for MT8173[1].
> > > 
> > > We've fixed these issues for new SoC, and we believe it is fully I2C
> > > compatible now. We'll add mt8173 support to this driver, so this driver
> > > will support both fully I2C compatible SoC and the current one.
> > 
> > From what you tell, I'd rather add the MT8173 support incrementally.
> > Let's get first the limited support properly implemented, then add
> > another controller.
> > 
> > I'll send out my draft for describing the quirks later today.
> 
> What do you think about my two proposals?

I think the quirks can describe our HW limitation without issue.
We are porting our i2c driver base on that. Will let you know the test
result.
Thanks

Joe.C
