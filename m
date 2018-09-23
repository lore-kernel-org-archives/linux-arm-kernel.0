From: qader.aymen@gmail.com (Aymen Qader)
Date: Sun, 23 Sep 2018 14:16:56 +0100
Subject: [PATCH 0/5] staging: vc04_services: Fix checkpatch.pl errors
Message-ID: <20180923131656.9062-1-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes the following checkpatch.pl errors in the
interface/vchi directory:

ERROR: space prohibited after/before that open/closed parenthesis
ERROR: code indent should use tabs where possible
ERROR: space required after that ','
ERROR: Macros with complex values should be enclosed in parentheses
ERROR: Macros with complex values should be enclosed in parenthese



Aymen Qader (5):
  staging: vc04_services: Fix "space prohibited"
  staging: vc04_services: Use tabs instead of spaces
  staging: vc04_services: Add spaces after commas
  staging: vc04_services: Surround complex macros
  staging: vc04_services: Remove spaces after '*'

 .../vc04_services/interface/vchi/vchi.h       | 200 +++++++++---------
 .../vc04_services/interface/vchi/vchi_cfg.h   |   2 +-
 2 files changed, 101 insertions(+), 101 deletions(-)

-- 
2.17.1
