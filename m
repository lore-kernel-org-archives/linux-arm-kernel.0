From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Feb 2015 08:52:39 -0800
Subject: [PATCH 1/4] ARM: dts: omap3-pandora: add common device tree
In-Reply-To: <572DFAE0-6B61-47B2-90FF-DF8A827DE735@goldelico.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
 <1423746226-700-2-git-send-email-marek@goldelico.com>
 <20150212160316.GL2531@atomide.com>
 <572DFAE0-6B61-47B2-90FF-DF8A827DE735@goldelico.com>
Message-ID: <20150212165238.GN2531@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dr. H. Nikolaus Schaller <hns@goldelico.com> [150212 08:34]:
> Am 12.02.2015 um 17:03 schrieb Tony Lindgren <tony@atomide.com>:
> 
> > I don't think dts
> > has a binding for MTDPART_SIZ_FULL type thing..
> 
> It does not need a special binding, we just set the size to 0. This
> is interpreted as MTDPART_SIZ_FULL later on. For board files,
> there is just a #define in include/linux/mtd/partitions.h and it appears
> to work.

Oh OK good to know.

Regards,

Tony
