From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2016 11:49:32 +0000
Subject: [PATCH 12/17] arm: Add new mach-oxnas
In-Reply-To: <1457005210-18485-13-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-13-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160303114932.GV19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 12:40:05PM +0100, Neil Armstrong wrote:
> Add mach-oxnas directory containing Kconfig and generic oxnas
> handling for future SoC specific features like system reset.

Looking at the current contents of oxnas.c, do you actually need it?
What happens if you boot your with your DT without this file being
built?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
