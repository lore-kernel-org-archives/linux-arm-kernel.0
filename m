From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 19:03:55 +0100
Subject: [PATCH 0/2] media: dt-bindings: extend the vpif bindings
Message-ID: <1487268237-4240-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch just fixes a couple whitespace errors in the vpif
bindings.

The second extends the example with an output port since we want
to support vpif display too.

These patches were initially a part of a larger series. Resending
separately with requested fixes i.e. removed the @0 from endpoint
and unnecessary reg property.

Bartosz Golaszewski (2):
  media: dt-bindings: vpif: fix whitespace errors
  media: dt-bindings: vpif: extend the example with an output port

 .../devicetree/bindings/media/ti,da850-vpif.txt    | 46 ++++++++++++++++------
 1 file changed, 34 insertions(+), 12 deletions(-)

-- 
2.9.3
