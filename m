From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Wed, 12 Sep 2018 17:05:50 +0100
Subject: [PATCH 0/2] dt-bindings: Cleanup spurious commas in hisilicon hip07
 dt.
Message-ID: <20180912160552.11604-1-Jonathan.Cameron@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring picked up on an issue in our sec dt binding doc where we had
an unnecessary comma in the addresses provided as part of the node name.
The comment wasn't fixed before the series was applied, hence this follow up.

This was a cut and paste job from a few of the its entries already present
in the hip07 dtsi.

This series tidies up this loose end.  It has no particular urgency
as nothing stops working if you have a comma present and it is unlikely
an userspace code would be using these.

Jonathan Cameron (2):
  dt-bindings: crypto: hip07-sec, drop incorrect commas
  arm64: dts: hisilicon hip07: drop commas from @address node names

 .../bindings/crypto/hisilicon,hip07-sec.txt   |  2 +-
 arch/arm64/boot/dts/hisilicon/hip07.dtsi      | 28 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.18.0
