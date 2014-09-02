From: dianders@chromium.org (Doug Anderson)
Date: Tue,  2 Sep 2014 09:14:27 -0700
Subject: [PATCH 0/2] Add input supplies to rk808 regulator
Message-ID: <1409674469-12123-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to specify the input supplies to the rk808 regulator.  This
patch series adds them to the driver.  Note that the bindings are
based atop Chris's most recent version at
<https://patchwork.kernel.org/patch/4817931/>.  If the regulator patch
is applied before Chris sends out his next version then I think Chris
could squash my bindings change (patch 2) into his next version.


Doug Anderson (2):
  regulator: RK808: Add proper input supplies for rk808
  dt-bindings: Add input supplies to rk808 bindings

 Documentation/devicetree/bindings/mfd/rk808.txt | 11 +++++++++++
 drivers/regulator/rk808-regulator.c             | 15 ++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.1.0.rc2.206.gedb03e5
