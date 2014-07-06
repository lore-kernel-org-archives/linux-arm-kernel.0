From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sun, 6 Jul 2014 10:34:06 -0400
Subject: Probe-defer and loading firmware
Message-ID: <CAKON4Oxa_jA1HH3aDH9NynszsPWe2as+XsYj1tFkVo-iwuTDnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just tried building the Broadcom wifi driver into my kernel which
didn't work.  The problem is that it needs to load firmware and the
filesystem with the firmware on it hasn't been mounted yet.  The
firmware is on my rootfs and I had rootwait on the kernel command
line.

Is it possible to get this to work? Shouldn't request-firmware do a
probe-defer type operation until after rootwait completes?

-- 
Jon Smirl
jonsmirl at gmail.com
