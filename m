From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 12 Feb 2013 17:26:40 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: fix some omap_device_build() calls that
 aren't compiled by default
In-Reply-To: <20130212171156.GH4801@atomide.com>
References: <alpine.DEB.2.00.1302120358130.14983@utopia.booyaka.com>
 <20130212171156.GH4801@atomide.com>
Message-ID: <alpine.DEB.2.00.1302121726110.29149@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Feb 2013, Tony Lindgren wrote:

> Thanks, I'll apply this into omap-for-v3.9/pm-wfi as the breaking
> commit is already in arm-soc/for-next.

OK thanks.  Looks like I'll have one more fix for one of the commits in 
arm-soc/for-next; working on it now.


- Paul
