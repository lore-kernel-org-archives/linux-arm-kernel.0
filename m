From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Jun 2015 16:27:19 +0200
Subject: [PATCH v2 0/4] net/macb: add sama5d2 support
Message-ID: <cover.1434637286.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is basically the support for another flavor of the GEM IP
configuration. It ended up being a series because of some little fixes made to
the binding documentation before adding the new compatibility string.

Bye,

v2: - fix bindings
    - add sama5d2 compatibility string to the binding documentation

Cyrille Pitchen (1):
  net/macb: add config for Atmel sama5d2 SoCs

Nicolas Ferre (3):
  net/macb: bindings doc: fix compatibility string
  net/macb: bindings doc/trivial: fix sama5d4 comment
  net/macb: bindings doc: add sama5d2 compatibility sting

 Documentation/devicetree/bindings/net/macb.txt | 5 +++--
 drivers/net/ethernet/cadence/macb.c            | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.1.3
