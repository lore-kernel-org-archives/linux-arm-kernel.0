From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 15 Mar 2014 16:04:52 +0100
Subject: [PATCH v2 0/2] irqchip: sun4i: Use handle_fasteoi_irq for all irqs
Message-ID: <1394895894-8891-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of my patchset for sun4i-irq.c to use handle_fasteoi_irq for all
irqs + follow up clean-up patch.

Changes since v2:
-adjust commit msg based on Thomas' comments, and merge patch 1 and 2 as
 they make more sense as 1 patch

Regards,

Hans
