From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 16 Sep 2016 12:11:05 -0500
Subject: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for ZTE
 device
In-Reply-To: <20160916163952.GH1041@n2100.armlinux.org.uk>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
 <20160916163952.GH1041@n2100.armlinux.org.uk>
Message-ID: <57DC27A9.3060307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> Maybe what we should've done with ZTE is insisted that they implement
> a complete new driver, rather than trying to shoe-horn it into PL011
> even though it is in theory PL011.

When I suggested that a year ago, I was shot down:

http://www.spinics.net/lists/arm-kernel/msg455888.html

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
