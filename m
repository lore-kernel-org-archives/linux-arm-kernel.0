From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2016 22:57:41 +0100
Subject: [PATCH 2/4] ARM: sa11x0/pxa: acquire timer rate from the clock
 rate
In-Reply-To: <1474312335-20997-3-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160926215741.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 09:12:13PM +0200, Robert Jarzmik wrote:
> As both pxa and sa1100 provide a clock to the timer, the rate can be
> inferred from the clock rather than hard encoded in a functional call.
> 
> This patch changes the pxa timer to have a mandatory clock which is used
> as the timer rate.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
