From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 20 Sep 2017 12:43:07 +0530
Subject: [PATCH 0/2] Handle return value of devm_kasprintf
Message-ID: <1505891589-6632-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_kasprintf() can fail here and we must check its return value.

Arvind Yadav (2):
  [PATCH 1/2] gpio: brcmstb: Handle return value of devm_kasprintf
  [PATCH 2/2] gpio: tb10x: Handle return value of devm_kasprintf

 drivers/gpio/gpio-brcmstb.c | 3 +++
 drivers/gpio/gpio-tb10x.c   | 3 +++
 2 files changed, 6 insertions(+)

-- 
1.9.1
