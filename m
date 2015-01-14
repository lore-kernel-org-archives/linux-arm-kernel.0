From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 14 Jan 2015 15:21:03 +0530
Subject: [PATCH 0/3] ARM: edma: Correct header file usage
In-Reply-To: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <54B63C07.9010301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 04:11 PM, Peter Ujfalusi wrote:
> Hi,
> 
> The linux/platform_data/edma.h file was used for API definition as well, which
> is not correct since the header should only contain platform data related
> structures, defines, etc.

I would like to queue this series through ARM-SoC for v3.20 with Mark's
and Ulf's acks added. I know its not the complete clean-up everyone
wanted to see but I also know Peter working on doing the complete
clean-up as well. So we are firmly on the path to removing
arch/arm/common/edma.c.

Thanks,
Sekhar
