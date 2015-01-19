From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 19 Jan 2015 11:41:07 +0100
Subject: [PATCH 0/4] ASoC: samsung: clean up references to outdated Kconfig
 symbols
Message-ID: <1421664067.9655.51.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few series of ARM cleanups regarding S5PC100 and S5PV210 were included
in v3.17. These series removed these five Kconfig symbols:
    MACH_AQUILA
    MACH_GONI
    MACH_SMDKC100
    MACH_SMDKC110
    MACH_SMDKV210

This series, done on top of next-20150119, removes the remaining
references to those five symbols. (The first two patches are actually
resends.)

Paul Bolle (4):
  ASoC: samsung: Remove goni or aquila with the WM8994
  ASoC: samsung: Remove PCM support for WM8580 on SMDK
  ASoC: samsung: MACH_SMDKC100 isn't supported anymore
  ASoC: samsung: remove outdated Kconfig references

 sound/soc/samsung/Kconfig          |  24 +--
 sound/soc/samsung/Makefile         |   4 -
 sound/soc/samsung/goni_wm8994.c    | 289 -------------------------------------
 sound/soc/samsung/smdk_wm8580pcm.c | 176 ----------------------
 4 files changed, 2 insertions(+), 491 deletions(-)
 delete mode 100644 sound/soc/samsung/goni_wm8994.c
 delete mode 100644 sound/soc/samsung/smdk_wm8580pcm.c

-- 
1.9.3
