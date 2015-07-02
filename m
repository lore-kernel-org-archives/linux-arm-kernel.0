From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 14:58:04 +0300
Subject: [PATCH 0/2] ARM: DTS: am437x-sk-evm: Use simple-card for audio support
Message-ID: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There is no reason to use the davinci-evm machine driver's compatible for audio
support since the setup is simple and the common simple-audio-card can handle it
just fine.
Also add McASP1 sleep pin configuration.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
  ARM: DTS: am437x-sk-evm: Switch using simple-audio-card for audio
    support

 arch/arm/boot/dts/am437x-sk-evm.dts | 42 +++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

-- 
2.4.5
