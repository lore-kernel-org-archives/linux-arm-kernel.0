From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 16 Feb 2017 13:27:14 +0800
Subject: [alsa-devel] [PATCH 0/2] ASoC: mediatek: add power-domain ctrl for
 2701
Message-ID: <1487222836-21174-1-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add power-domain get/put ctrl for 2701 and add relative node description
in binding doc.

Garlic Tseng (2):
  ASoC: mediatek: add power-domain get/put ctrl for mt2701
  ASoC: mediatek: add power-domains for mt2701-afe-pcm.txt

 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 2 ++
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c                 | 2 ++
 2 files changed, 4 insertions(+)

-- 
1.9.1
