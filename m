From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Feb 2015 19:37:03 +0000
Subject: [RFC PATCH] arm: cti: fix build for cti.h
In-Reply-To: <1424326185-31463-1-git-send-email-dinguyen@opensource.altera.com>
References: <1424326185-31463-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20150220193702.GF1767@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 06:09:44AM +0000, dinguyen at opensource.altera.com wrote:
> I would to like check to see if this is right thing to do for cti.h. Our
> downstream kernel's PMU support is using cti.h. But I don't see any other
> upstream driver using cti.h, so I'm not sure if this file should be removed?

The file was originally added because there was some pending OMAP code to
make use of it. However, then the upstream OMAP development more or less
stopped and the follow-up patches never came.

I'd vote for removing the file if it's not used in mainline.

Will
