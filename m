From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 22 Jul 2013 16:49:27 +0200
Subject: [PATCH 1/2] arm: ixp4xx: set cohorent_dma_mask for ethernet
 platform devices
In-Reply-To: <1374424823.2804.25.camel@deadeye.wl.decadent.org.uk> (Ben
 Hutchings's message of "Sun, 21 Jul 2013 17:40:23 +0100")
References: <1374315339-31469-1-git-send-email-jogo@openwrt.org>
 <1374315339-31469-2-git-send-email-jogo@openwrt.org>
 <m3ip04ezty.fsf@intrepid.localdomain>
 <1374424823.2804.25.camel@deadeye.wl.decadent.org.uk>
Message-ID: <m3bo5uabuw.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Hutchings <bhutchings@solarflare.com> writes:

> I think the problem is that the platform device and the platform data
> have not been properly separated.  The machine-specific setup functions
> should be passing the eth_plat_info and MAC ID into a common ixp4xx
> function which would then create the platform device with the correct
> DMA mask etc.

That's also my idea. Will look at this.
-- 
Krzysztof Halasa
