From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Mar 2013 09:42:45 -0700
Subject: [RFC 0/2] ARM: OMAP: dma.h cleanup
In-Reply-To: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <20130320164245.GO16413@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [130313 13:20]:
> I don't know is this good or bad idea, thus RFC.
> 
> I got this idea after noticing that McBSP DMA channel definitions are no
> longer used for OMAP2 and EAC DMA channel were never used in upstream.
> Scripts here are used to remove all of those unused ones.
> 
> Build tested with omap1_defconfig and omap2plus_defconfig.

Yeah let's get rid of them. I'll apply these into omap-for-v3.10/cleanup.

Regards,

Tony
