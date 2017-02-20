From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 21 Feb 2017 00:04:10 +0200
Subject: [PATCH v4 29/36] media: imx: mipi-csi2: enable setting and
 getting of frame rates
In-Reply-To: <1487211578-11360-30-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-30-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170220220409.GX16975@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Wed, Feb 15, 2017 at 06:19:31PM -0800, Steve Longerbeam wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Setting and getting frame rates is part of the negotiation mechanism
> between subdevs.  The lack of support means that a frame rate at the
> sensor can't be negotiated through the subdev path.

Just wondering --- what do you need this for?

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
