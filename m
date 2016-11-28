From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Nov 2016 10:37:38 +0000
Subject: [PATCH] ARM: dts: mvebu: Add Armada 38x labels and clean up
 Turris Omnia
In-Reply-To: <1480272700-28888-1-git-send-email-afaerber@suse.de>
References: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
 <1480272700-28888-1-git-send-email-afaerber@suse.de>
Message-ID: <20161128103738.GT14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 07:51:39PM +0100, Andreas F?rber wrote:
> To more consistently reference nodes by label, add labels for sata,
> usb2, sdhci and usb3 nodes.
> 
> Convert all other 38x boards for consistency. Add labels for nfc and rtc.

Please don't do this for clearfog - there's changes in the pipeline which
completely replace armada-388-clearfog.dts because there's a "base" and
"pro" versions of this hardware now, and making such a huge change will
effectively mean we have to start over with the DT files.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
