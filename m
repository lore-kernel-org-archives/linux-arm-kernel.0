From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 10 Jan 2014 11:04:36 -0600
Subject: AArch64 kernel image decompression
Message-ID: <20140110170436.GS8153@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Will-

Scanning the Documentation/arm64/booting.txt document, I came across
this, listing an optional step a bootloader might take:

"The AArch64 kernel does not currently provide a decompressor and
therefore requires decompression (gzip, etc.) to be performed by the
boot loader if a compressed Image target (e.g. Image.gz) is used."

Do you envision that, if a decompressor is desired, it will always be
the responsibility of a bootloader to implement it?

In other words, would you accept patches adding support for building
zImages (and others) for AArch64?

Thanks,
   Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
