From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2017 10:28:07 +0000
Subject: [PATCH v4 23/36] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <1487211578-11360-24-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-24-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170216102806.GI27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 06:19:25PM -0800, Steve Longerbeam wrote:
> Adds MIPI CSI-2 Receiver subdev driver. This subdev is required
> for sensors with a MIPI CSI2 interface.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

Just like I reported on the 30th January:

.git/rebase-apply/patch:236: trailing whitespace.
 *
warning: 1 line adds whitespace errors.

This needs fixing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
