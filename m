From: andrealmeid@riseup.net (andrealmeid at riseup.net)
Date: Mon, 12 Nov 2018 22:37:31 -0200
Subject: [PATCH v2 0/2] Staging: vchi: Add license id and change int type
Message-ID: <20181113003733.9615-1-andrealmeid@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andr? Almeida <andrealmeid@riseup.net>

Fix the following checkpatch issues:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
CHECK: Prefer kernel type 's32' over 'int32_t'

Changes in v2:
- Splits commits in a patch set
- Fixes licenses in SPDX identifier
- Adds a more descriptive commit message

v1: https://www.spinics.net/lists/arm-kernel/msg685603.html

Andr? Almeida (2):
  staging: vchi: change type 'int32_t' to 's32'
  stagin: vchi: Add SPDX-License-Identifier

 drivers/staging/vc04_services/interface/vchi/vchi_mh.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.1
