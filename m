From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2016 22:58:33 +0100
Subject: [PATCH 4/4] ARM: sa11x0/pxa: get rid of get_clock_tick_rate
In-Reply-To: <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160926215833.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 09:12:15PM +0200, Robert Jarzmik wrote:
> The last user of this function is gone, so remove it. The clock API
> should now be used to get clock rates.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
