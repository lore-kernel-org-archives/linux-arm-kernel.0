From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 13 Aug 2017 18:13:07 +0530
Subject: [PATCH 0/6] drivers: make snd_pcm_hardware const
Message-ID: <1502628193-3343-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make snd_pcm_hardware structures const.

Bhumika Goyal (6):
  [media] usb: make snd_pcm_hardware const
  [media] pci: make snd_pcm_hardware const
  drm: bridge: dw-hdmi: make snd_pcm_hardware const
  usb: gadget: make snd_pcm_hardware const
  staging: bcm2835-audio:  make snd_pcm_hardware const
  [media] tuners: make snd_pcm_hardware const

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c       | 2 +-
 drivers/media/pci/cobalt/cobalt-alsa-pcm.c                | 4 ++--
 drivers/media/pci/cx18/cx18-alsa-pcm.c                    | 2 +-
 drivers/media/pci/cx23885/cx23885-alsa.c                  | 2 +-
 drivers/media/pci/cx25821/cx25821-alsa.c                  | 2 +-
 drivers/media/pci/ivtv/ivtv-alsa-pcm.c                    | 2 +-
 drivers/media/pci/saa7134/saa7134-alsa.c                  | 2 +-
 drivers/media/tuners/tda18271-maps.c                      | 4 ++--
 drivers/media/usb/cx231xx/cx231xx-audio.c                 | 2 +-
 drivers/media/usb/em28xx/em28xx-audio.c                   | 2 +-
 drivers/media/usb/go7007/snd-go7007.c                     | 2 +-
 drivers/media/usb/tm6000/tm6000-alsa.c                    | 2 +-
 drivers/media/usb/usbtv/usbtv-audio.c                     | 2 +-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 4 ++--
 drivers/usb/gadget/function/u_audio.c                     | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

-- 
1.9.1
