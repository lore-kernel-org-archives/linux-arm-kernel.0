From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 13 Feb 2013 01:13:54 +0200
Subject: [PATCH] ARM: OMAP1: fix USB host on 1710
In-Reply-To: <alpine.DEB.2.00.1301250809500.471@utopia.booyaka.com>
References: <1359066295-20382-1-git-send-email-aaro.koskinen@iki.fi>
 <alpine.DEB.2.00.1301250809500.471@utopia.booyaka.com>
Message-ID: <20130212231353.GA9991@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 25, 2013 at 08:10:05AM +0000, Paul Walmsley wrote:
> On Fri, 25 Jan 2013, Aaro Koskinen wrote:
> 
> > There is a long-standing bug that OHCI USB host controller does
> > not respond on 1710, because of wrong clock definitions. See e.g.
> > http://marc.info/?l=linux-omap&m=119634441229321&w=2. All register reads
> > return just zeroes:
> 
> Thanks, queued for v3.8-rc fixes.

What happened to this patch? Will it go to 3.9?

A.
