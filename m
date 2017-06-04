From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 4 Jun 2017 23:04:16 +0200
Subject: [PATCH 0/3] ARM-XEN: Adjustments for __set_phys_to_machine_multi()
Message-ID: <9b9230f4-0f00-e019-75b4-571e29b52998@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Jun 2017 22:45:54 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Improve a size determination
  Delete an error message for a failed memory allocation
  Adjust one function call together with a variable assignment

 arch/arm/xen/p2m.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.13.0
