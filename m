From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 13 Jun 2014 22:36:00 +0200
Subject: [PATCH v2 0/4] pinctrl: sunxi: Properly handle level triggered gpio
 irqs
Message-ID: <1402691764-17562-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is v2 of my sunxi-pinctrl gpio irq patches, mainly aimed at get level
triggered irqs to work properly for use with oob sdio irqs.

Changes since v1:
-Post these patches as a separate series, rather then as part of a larger
 patchset touching multiple subsystems
-"pinctrl: sunxi: Move setting of mux to irq type from unmask to request_resourc
 -Added a check for func == NULL
-"pinctrl: sunxi: Define enable / disable irq callbacks for level triggered irqs
 -Use sunxi_pinctrl_irq_ack() and sunxi_pinctrl_irq_unmask()

Regards,

Hans
