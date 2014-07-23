From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 24 Jul 2014 00:58:41 +0200
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <94F87063-D717-435B-B7C5-EDAC9B26742C@perenite.com>
References: <1406154923-13612-1-git-send-email-yahoo@perenite.com>
 <1406154923-13612-2-git-send-email-yahoo@perenite.com>
 <20140723224236.GC28485@lunn.ch>
 <94F87063-D717-435B-B7C5-EDAC9B26742C@perenite.com>
Message-ID: <20140723225841.GD28485@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> For the marvell,mv78230-a0-i2c unfortunately i've spend 3 hours
> trying to understand this but it only works with this on the
> ix4-300d :(. There was multiple patch around this and maybe one
> broke the auto-detect part of this, I've tried compiling with some
> 3.10 or lower kernel but no luck here I still have to put this a0
> option.

Lets first confirm you have an a0 SoC.

At boot time, it should print:

pr_info("MVEBU SoC ID=0x%X, Rev=0x%X\n", soc_dev_id, soc_rev);

What revision do you have?

If the auto detect code really is broken, Gregory will likely take a
look.

	Andrew
