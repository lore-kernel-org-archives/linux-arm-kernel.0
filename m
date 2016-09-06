From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 15:46:07 +0100
Subject: [PATCH 0/3] SA11x0/PXA pcmcia fixes
In-Reply-To: <20160829100232.GC1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
Message-ID: <20160906144606.GZ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 11:02:32AM +0100, Russell King - ARM Linux wrote:
> Further to the DS suspend/resume fix, here's a few more for SA11x0/PXA.
> 
>  drivers/pcmcia/sa11xx_base.c | 8 ++++----
>  drivers/pcmcia/soc_common.c  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

If no one objects, I'll queue these three fixes for -rc6 as well.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
