From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 16 Sep 2014 22:25:02 +0200
Subject: Cortex-M and zImage
Message-ID: <CAGhQ9VzzSq4P5BKM3UBBCPT61g3T1RHFhttfA-KkWGCcrjaW6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am working on Linux support for the NXP LPC18xx/43xx family of
Cortex-M3/M4 microcontrollers. Building zImage for Cortex-M fails
with the following two errors:
error: arch/arm/boot/compressed/piggy.gzip.o: Conflicting architecture
profiles M/A
linux/arch/arm/boot/compressed/head.S:794: undefined reference to
`CONFIG_PROCESSOR_ID'

The last error is easy to fix. But the first about conflicting arch is
harder.

As far as I know zImage on Cortex-M is not supported or not tested.

Are there any plans to support zImage on Cortex-M?
If so does anyone have an idea how the conflicting arch issue could
be solved?

btw, building with 'make Image' works fine and I have been running
Linux for a while on the NXP LPC4357.

regards
Joachim Eastwood
