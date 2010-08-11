From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 11 Aug 2010 16:06:19 -0700
Subject: RTC: LPC32xx: Introduce RTC driver for the LPC32xx (v2)
Message-ID: <1281567980-12792-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the LPC32xx built-in RTC. This is
a persistent RTC with alarm on it's own power domain and a
dedicated oscillator. UIE emulation is used for *_UIE_* ioctls.

v2 includes updates from the initial review of the RTC driver.

The patch can be pulled from:
	git://git.lpclinux.com/linux-2.6-lpc rtc-lpc32xx_v2
