From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Sep 2016 10:09:01 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <87twe0krym.fsf@belgarion.home>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home>
 <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160831102721.GR1041@n2100.armlinux.org.uk>
 <87twe0krym.fsf@belgarion.home>
Message-ID: <20160903090901.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 09:19:13AM +0200, Robert Jarzmik wrote:
> >From 977c16201a752aac8a8fb2da1f4271795f0b2122 Mon Sep 17 00:00:00 2001
> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Date: Thu, 1 Sep 2016 08:31:08 +0200
> Subject: [PATCH] pcmcia: lubbock: fix sockets configuration
> 
> On lubbock board, the probe of the driver crashes by dereferencing very
> early a platform_data structure which is not set, in
> pxa2xx_configure_sockets().

Patch applied, with some fixups for the error code propagation changes
and edited the patch description a little.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
