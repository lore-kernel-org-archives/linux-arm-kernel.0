From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2017 22:20:07 +0000
Subject: [PATCH v4 00/36] i.MX Media Driver
In-Reply-To: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170216222006.GA21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 06:19:02PM -0800, Steve Longerbeam wrote:
> In version 4:

With this version, I get:

[28762.892053] imx6-mipi-csi2: LP-11 timeout, phy_state = 0x00000000
[28762.899409] ipu1_csi0: pipeline_set_stream failed with -110

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
