From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 10 May 2010 08:33:31 +0100
Subject: [PATCH 1/2] regulator: make max8925 sharing one driver structure
In-Reply-To: <20100509224644.GE3269@sortiz.org>
References: <o2o771cded01005040021o74bb8c3cr22c7be427333774b@mail.gmail.com>
	<20100509224644.GE3269@sortiz.org>
Message-ID: <1273476811.3288.2.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-10 at 00:46 +0200, Samuel Ortiz wrote:
> Hi Haojian,
> 
> On Tue, May 04, 2010 at 03:21:42AM -0400, Haojian Zhuang wrote:
> > From 782297964a48a3b8547a99de3b5c24d8f02b99ec Mon Sep 17 00:00:00 2001
> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
> > Date: Thu, 29 Apr 2010 13:33:50 -0400
> > Subject: [PATCH] regulator: make max8925 sharing one driver structure
> > 
> > Remove a lot of driver structures in max8925 driver. Make regulators share
> > one driver structure.
> Patch applied, thanks.
> 
> Liam, I'll carry those 2 patches with my mfd tree if you're fine with it.

Both :-

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

Thanks

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
