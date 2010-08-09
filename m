From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  9 Aug 2010 09:17:28 -0700
Subject: RTC: LPC32xx: Introduce RTC driver for the LPC32xx
Message-ID: <1281370650-29520-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the LPC32xx built-in RTC. This is
a persistent RTC with alarm on it's own power domain and a
dedicated oscillator. UIE emulation is used for *_UIE_* ioctls.
