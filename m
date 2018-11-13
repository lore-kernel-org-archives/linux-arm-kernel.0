From: andrealmeid@riseup.net (andrealmeid at riseup.net)
Date: Tue, 13 Nov 2018 16:58:33 -0200
Subject: [PATCH v3 0/2] Staging: vchi: Add license id and change int type
Message-ID: <20181113185835.14429-1-andrealmeid@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andr? Almeida <andrealmeid@riseup.net>

Fix the following checkpatch issues:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
CHECK: Prefer kernel type 's32' over 'int32_t'

Changes in v3:
- Remove license text from header file
- Modify commit message

Changes in v2:
- Splits commits in a patch set
- Fixes licenses in SPDX identifier
- Adds a more descriptive commit message

v2: https://www.spinics.net/lists/arm-kernel/msg686817.html

Andr? Almeida (2):
  staging: vchi: change type 'int32_t' to 's32'
  stagin: vchi: Add SPDX-License-Identifier

 .../vc04_services/interface/vchi/vchi_mh.h    | 32 ++-----------------
 1 file changed, 2 insertions(+), 30 deletions(-)

-- 
2.19.1
