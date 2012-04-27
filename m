From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 16:39:08 +0800
Subject: [PATCH 0/9] add more devicetree support in arch-mmp
Message-ID: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Fix the build issue in mmp-dt.c since irq interface changed.
2. Parse intc in new irq that could support both pxa168 and mmp2.
After arch-mmp is totally moved to device tree, irq-pxa168 and irq-mmp2
will be removed.
3. Parse interrupt in gpio controller.
4. Append timer with device tree.
5. Update documents.
