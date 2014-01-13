From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 13 Jan 2014 11:29:46 +0100
Subject: No subject
Message-ID: <1389608988-10981-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for inverting the PWM output in hardware by
setting the POUTC bit in the PWMCR register. This feature is
controlled via the standard DT flas for PWMs.

The first patch does a minor source cleanup without any functional
change.
