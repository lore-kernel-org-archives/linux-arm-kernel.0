From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 17:56:20 +0200
Subject: [PATCH 0/3] ARM: dmabounce: Adjustments for four function
 implementations
Message-ID: <697e7810-d280-08f3-2a24-026ff41e15a3@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 17:34:56 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Improve a size determination in two functions
  Delete an error message for a failed memory allocation in two functions
  Combine substrings for two messages

 arch/arm/common/dmabounce.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

-- 
2.13.0
