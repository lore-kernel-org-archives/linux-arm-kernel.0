From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Aug 2018 11:47:33 +0100
Subject: [PATCH 0/9] ALSA: remove redundant variables
Message-ID: <20180801104742.4328-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Clean up code by removing redundant variables that were
detected by clang

Colin Ian King (9):
  ALSA: asihpi: remove redundant variable max_streams
  ALSA: cs5535audio: remove redundant pointer 'dma'
  ALSA: emu10k1: remove redundant variable attn
  ALSA: ens137x: remove redundant array pcm_devs
  ALSA: sonicvibes: remove redundant pointer 'dir'
  ASoC: nau8540: remove redundant variable osrate
  ASoC: stm32: remove redundant pointers 'priv' and 'rtd'
  ALSA: usb-audio: remove redundant pointer 'urb'
  ALSA: intel_hdmi: remove redundant variable cfg_val

 sound/pci/asihpi/hpi6205.c          | 5 -----
 sound/pci/cs5535audio/cs5535audio.c | 7 +------
 sound/pci/emu10k1/emupcm.c          | 3 +--
 sound/pci/ens1370.c                 | 3 +--
 sound/pci/sonicvibes.c              | 2 --
 sound/soc/codecs/nau8540.c          | 3 ---
 sound/soc/stm/stm32_adfsdm.c        | 8 +-------
 sound/usb/endpoint.c                | 2 --
 sound/x86/intel_hdmi_audio.c        | 2 --
 9 files changed, 4 insertions(+), 31 deletions(-)

-- 
2.17.1
