From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Dec 2009 13:18:01 +0800
Subject: [PATCH 0/7] pxa/sa1100: irqs.h cleanup
Message-ID: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Companion chip's IRQs and board specific IRQs should really be
moved outside of irqs.h, which keeps irqs.h generic enough.

This patch series includes the following:

[PATCH 1/7] [ARM] sa1100: remove unreferenced IRQ definitions
[PATCH 2/7] [ARM] locomo: avoid the unnecessary cascade of keyboard IRQ
[PATCH 3/7] [ARM] locomo: remove unused IRQs and avoid unnecessary cascade
[PATCH 4/7] [ARM] locomo: allow cascaded IRQ base to be specified by platforms
[PATCH 5/7] [ARM] sa1111: avoid using hardcoded IRQ numbers for PCMCIA driver
[PATCH 6/7] [ARM] sa1111: allow cascaded IRQs to be used by platforms
[PATCH 7/7] [ARM] pxa: move board board IRQ definitions out of irqs.h
