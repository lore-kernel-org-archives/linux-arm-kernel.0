From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 31 Dec 2016 22:54:25 +0100
Subject: [PATCH 0/6] staging: vchiq_arm: Fine-tuning for some function
 implementations
Message-ID: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 31 Dec 2016 22:42:34 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (6):
  Use kmalloc_array() in dump_phys_mem()
  Adjust 13 checks for null pointers
  One check less in dump_phys_mem() after error detection
  Delete an error message for a failed memory allocation in dump_phys_mem()
  Combine substrings for 24 messages
  Delete an unnecessary return statement in two functions

 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 212 +++++++++++----------
 1 file changed, 109 insertions(+), 103 deletions(-)

-- 
2.11.0
