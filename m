From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 15:49:12 +0100
Subject: [PATCH 0/2] ASoC: sun4i-spdif: Changes in preparation of supporting
 new SoCs
Message-ID: <20161220144914.30945-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,
please find attached two patches. First being a cleanup of something that
shouldn't be in the code and the second adds the mechanism for supporting
newer Allwiner SoCs. There was a third patch in the series and that was
bringing in support of SPDIF on the Allwinner H3 but I've not been able to
test it so that I hear audio. As soon as I get some hardware with a SPDIF
connection I will confirm and push.
BR,
CK 

Marcus Cooper (2):
  ASoC: sun4i-spdif: remove legacy dapm components
  ASoC: sun4i-spdif: Add quirks to the spdif driver

 sound/soc/sunxi/sun4i-spdif.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

-- 
2.11.0
