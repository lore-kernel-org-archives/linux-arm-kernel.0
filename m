From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 22 Feb 2017 14:43:44 +0100
Subject: [PATCH v2 0/3] media: dt-bindings: extend the vpif bindings
Message-ID: <1487771027-7763-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series extends the DT bindings for TI vpif with an output
port and enable-gpios property.

The first patch just fixes a couple whitespace errors in the vpif
bindings.

The second extends the example with an output port since we want
to support vpif display too.

The third adds an optional property for selecting vpif functionality
by driving GPIOs which is needed on some boards.

v1 -> v2:
- added patch 3/3
- specified the purpose of port at 0 and port at 1 nodes

Bartosz Golaszewski (3):
  media: dt-bindings: vpif: fix whitespace errors
  media: dt-bindings: vpif: extend the example with an output port
  media: dt-bindings: vpif: new optional property

 .../devicetree/bindings/media/ti,da850-vpif.txt    | 57 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

-- 
2.9.3
