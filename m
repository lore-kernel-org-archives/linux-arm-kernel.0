From: qader.aymen@gmail.com (Aymen Qader)
Date: Mon, 24 Sep 2018 18:27:39 +0100
Subject: [PATCH v3 0/4] staging: vc04_services: Fix checkpatch.pl errors
In-Reply-To: <20180923140620.14583-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
Message-ID: <20180924172743.21153-1-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes the following checkpatch.pl errors in the
interface/vchi directory:

ERROR: space prohibited after/before that open/closed parenthesis
ERROR: code indent should use tabs where possible
ERROR: space required after that ','
ERROR: Macros with complex values should be enclosed in parentheses
ERROR: "foo * bar" should be "foo* bar"

Aymen Qader (4):
  staging: vc04_services: Fix "space prohibited"
  staging: vc04_services: Use tabs instead of spaces
  staging: vc04_services: Remove unused macros
  staging: vc04_services: Remove spaces after '*'

 .../vc04_services/interface/vchi/vchi.h       | 208 +++++++-----------
 .../vc04_services/interface/vchi/vchi_cfg.h   |   2 +-
 2 files changed, 86 insertions(+), 124 deletions(-)

-- 
2.17.1
