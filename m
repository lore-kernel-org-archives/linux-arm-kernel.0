From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 19 Feb 2015 00:09:44 -0600
Subject: [RFC PATCH] arm: cti: fix build for cti.h
Message-ID: <1424326185-31463-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Hi,

I would to like check to see if this is right thing to do for cti.h. Our
downstream kernel's PMU support is using cti.h. But I don't see any other
upstream driver using cti.h, so I'm not sure if this file should be removed?

Thanks,

Dinh Nguyen (1):
  arm: cti: fix up cti pmu build

 arch/arm/include/asm/cti.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
--
2.2.1
