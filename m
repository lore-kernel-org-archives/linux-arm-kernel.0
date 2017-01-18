From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2017 23:20:29 +0000
Subject: [PATCH] ARM: Reduce "CPU: shutdown" message to debug level
In-Reply-To: <20170118225328.2597-1-f.fainelli@gmail.com>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
 <20170118225328.2597-1-f.fainelli@gmail.com>
Message-ID: <20170118232029.GU27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 02:53:26PM -0800, Florian Fainelli wrote:
> Similar to c68b0274fb3c ("ARM: reduce "Booted secondary processor"
> message to debug level"), demote the "CPU: shutdown" pr_notice() into a
> pr_debug().

Much better, and thanks for dropping the "performance" argument as well.
CPU hotplug isn't about performance :)

Please put this in the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
