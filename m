From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2016 22:58:11 +0100
Subject: [PATCH 3/4] watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
In-Reply-To: <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160926215811.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 09:12:14PM +0200, Robert Jarzmik wrote:
> The OS timer rate used for the watchdog can now be fetched from the
> standard clock API. This will remove the last user of
> get_clock_tick_rate() in both pxa and sa11x0 architectures.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
