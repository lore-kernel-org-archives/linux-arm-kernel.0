From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Apr 2016 11:02:05 +0100
Subject: [PATCH 2/2] ARM: at91: pm: switch to the PIE infrastructure
In-Reply-To: <1459668234-16033-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1459668234-16033-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160404100205.GT19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2016 at 09:23:54AM +0200, Alexandre Belloni wrote:
> -	/* Copy the pm suspend handler to SRAM */
> -	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
> -			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);

This is proper and correct use of fncpy().

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
