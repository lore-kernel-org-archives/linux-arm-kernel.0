From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2016 09:56:58 -0800
Subject: [PATCH 2/7] i2c: omap: Fix PM regression with deferred probe for
 pm_runtime_reinit
In-Reply-To: <20160211173427.GB1524@katana>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-3-git-send-email-tony@atomide.com>
 <20160211173427.GB1524@katana>
Message-ID: <20160211175658.GW19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wolfram Sang <wsa@the-dreams.de> [160211 09:35]:
> 
> > Wolfram, I'd like to merge this along with other related fixes via
> > the ARM SoC tree if no objections, please review and ack if this
> > look OK to you.
> 
> Well, since most patches seem to be picked up individually now, I'd
> prefer to do the same. This is v4.5 material, or?

Sure please do, thanks. And yes for v4.5 please. Although
I've only seen this happen with the MMC driver so far, there's
still a slight chance of this happening with the other drivers
using omap_device.

Regards,

Tony
