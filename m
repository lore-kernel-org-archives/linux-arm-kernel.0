From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 14 Jan 2018 21:40:57 +0100
Subject: [PATCH 0/3] mfd/abx500-core: Adjustments for eight function
 implementations
Message-ID: <d1862d7a-412e-9aaf-8200-bb2070ee402a@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jan 2018 21:38:42 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
    in abx500_register_ops()
  Improve two size determinations in abx500_register_ops()
  Adjust 14 checks for null pointers

 drivers/mfd/abx500-core.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

-- 
2.15.1
