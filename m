From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jan 2017 09:18:45 -0800
Subject: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition
 table
In-Reply-To: <20170105153637.GA4310@atomide.com>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
 <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
 <20170105153637.GA4310@atomide.com>
Message-ID: <20170105171845.GK4310@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170105 07:37]:
> * Teresa Remmet <t.remmet@phytec.de> [170105 06:57]:
> > To improve NAND safety we updated the partition layout.
> > Added barebox backup partition and removed kernel and oftree
> > partition. They are kept in ubi now.
> 
> What about the users with earlier partition tables?
> 
> Please read about "flag day" changes, typically they are not
> acceptable.

Adding Brian and Adam to Cc. Can you guys come up with some
solution on this?

I'm suggesting we leave the kernel nodes empty and let u-boot
populate them, so maybe you guys can discuss this on the related
lists.

The rest of the series looks fine to me so applying it into
omap-for-v4.11/dt.

Cheers,

Tony
