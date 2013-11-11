From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Nov 2013 16:28:25 +0800
Subject: [PATCH 1/5] ARM: dts: i.MX51: Move usbphy0 node from AIPS1
In-Reply-To: <1384157706.39361830@f119.i.mail.ru>
References: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
 <20131111081148.GA11083@S2101-09.ap.freescale.net>
 <1384157706.39361830@f119.i.mail.ru>
Message-ID: <20131111082823.GB11083@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 12:15:06PM +0400, Alexander Shiyan wrote:
> > On Thu, Nov 07, 2013 at 12:45:04PM +0400, Alexander Shiyan wrote:
> > > usbphy0 is not a part of AIPS1, so move this node under usbotg.
> > > Additionally this patch removes useless "status" property.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > 
> > Applied all except #4.  I would add those pingroups only when there are
> > in-tree users of it.
> 
> Please revert this one part too [1/5]. This change is incorrect. I will make
> other solution later.
> Thanks.

Okay.  Dropped the patch 'ARM: dts: i.MX51: Move usbphy0 node from AIPS1'.

Shawn
