From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 26 Nov 2009 18:58:58 +0100
Subject: ARM: pxa: add support for Raumfeld audio devices [v2]
Message-ID: <1259258341-31114-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second round of patches to add support for Raumfeld audio
devices. I hope to have addressed all issued that came up as response
to the first spin. If there's anything missing, please let me know.

I squashed most patches together now, hoping it's easier to review
this time.

Daniel

[PATCH 1/3] ARM: pxa/raumfeld: add platform support
[PATCH 2/3] ALSA: ARM: add Raumfeld audio support
[PATCH 3/3] ARM: pxa/raumfeld: Add defconfig
