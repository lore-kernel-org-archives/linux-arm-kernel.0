From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2016 13:29:56 +0000
Subject: [PATCH 12/17] arm: Add new mach-oxnas
In-Reply-To: <3226743.49AyJYeiGh@wuerfel>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-13-git-send-email-narmstrong@baylibre.com>
 <3226743.49AyJYeiGh@wuerfel>
Message-ID: <20160303132956.GW19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 01:56:56PM +0100, Arnd Bergmann wrote:
> As Russell mentioned, the entire file is not really needed either, but
> so far we have left the trivial per-platform files in place generally.

I think that's something we should be looking to remove: if the
per-platform files give no benefit, then there is no point in
having them, and they just increase the size of the code base.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
