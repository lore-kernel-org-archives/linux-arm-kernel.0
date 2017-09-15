From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 15 Sep 2017 18:00:07 +0200
Subject: [PATCH 0/2] [media] C8SECTPFE: Adjustments for
 c8sectpfe_frontend_attach()
Message-ID: <3e5fcfbe-828a-8c15-12d4-c74e8a1f20f1@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 15 Sep 2017 17:55:43 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve two size determinations

 drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.14.1
