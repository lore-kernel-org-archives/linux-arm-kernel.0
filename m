From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 Aug 2013 19:55:39 +0200
Subject: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <5200E684.5080003@free-electrons.com>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather>
 <5200E684.5080003@free-electrons.com>
Message-ID: <20130806195539.1690c0a6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 06 Aug 2013 14:05:24 +0200, Gregory CLEMENT wrote:

> But we shouldn't use it alone: we should always use:
> compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> 
> From my point of view using  "marvell,mv78230-i2c" alone is an error.

I disagree. I believe the driver should support a Device Tree file that
uses "marvell,mv78230-i2c" alone.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
