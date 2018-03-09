From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 9 Mar 2018 17:00:19 +0100
Subject: [PATCH v2 0/3] mfd/abx500-core: Adjustments for eight function
 implementations
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
    in abx500_register_ops()
  Improve two size determinations in abx500_register_ops()
  Adjust 14 checks for null pointers

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2:
Lee Jones requested a resend for these patches. The changes were rebased
on source files from Linux next-20180308.

 drivers/mfd/abx500-core.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

-- 
2.15.1
