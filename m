From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2016 16:38:02 +0000
Subject: [PATCH 1/2] drm/i2c: tda998x: allow interrupt to be shared
In-Reply-To: <20161117122457.GC21156@e106950-lin.cambridge.arm.com>
References: <E1c6xls-0006wf-Jg@rmk-PC.armlinux.org.uk>
 <20161117122457.GC21156@e106950-lin.cambridge.arm.com>
Message-ID: <20161117163801.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 12:24:57PM +0000, Brian Starkey wrote:
> I tested these two and the power-down one on mali-dp and hdlcd. The
> output, hotplugging and EDID continued to work; so you can have my
> tested-by and reviewed-by for all 3.

Thanks!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
