From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Nov 2014 13:54:38 +0100
Subject: [PATCH 0/5] sun6i: Add A31s (pinctrl) support
Message-ID: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime and Linus,

Here is a patch series for the A31s, a variant of the already supported
A31 with less pins.

As such this patch-set introduces pinctrl support for it + a dtsi + the
first board using it.

I'm not sure if sunxi pinctrl patches go through Maxime's tree or Linus' tree,
so I'll leave figuring out who takes what patches to you two.

Regards,

Hans
