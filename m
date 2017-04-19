From: sramana@codeaurora.org (Srinivas Ramana)
Date: Wed, 19 Apr 2017 12:03:58 +0530
Subject: LDM/STM alignment fixups on arm64
Message-ID: <58F704D6.6000301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While understanding how the alignment are handled on arm and arm64, we 
came across the fixups for LDM/LDRD/STM on arm where as these fixups are 
not present on arm64.

There may be some specific reason why these fixups are not ported to 
arm64. Can you please help us understand this?

With this difference in how kernel handles 32-bit apps on arm and arm64, 
there can be apps which are working without abort on arm, but fail on 
arm64 (SIGBUS). We have tried to get some history on web, but not 
successful.

If this is indeed missing on arm64, do you see any issue if its ported 
(does it fail any guidance)?

Thanks,
-- Srinivas R


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
