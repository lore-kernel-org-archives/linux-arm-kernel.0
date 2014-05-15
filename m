From: geoff@infradead.org (Geoff Levand)
Date: Thu, 15 May 2014 16:06:31 -0700
Subject: arm64 entry point
Message-ID: <1400195191.12756.9.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There is some discrepancy between what booting.txt says and what our
linker script defines as the kernel entry point.

Here is booting.txt:

  The primary CPU must jump directly to the first instruction of the
  kernel image.

And the linker script:

  ENTRY(stext)

Should we change booting.txt, or the linker script?

-Geoff
