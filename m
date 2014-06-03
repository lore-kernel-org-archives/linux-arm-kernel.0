From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  3 Jun 2014 10:11:27 +0200
Subject: [PATCH v3 0/2] mmc: Add SDIO function devicetree subnode parsing
Message-ID: <1401783089-18065-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v3 of my submission of Sascha Hauer's
"mmc: Add SDIO function devicetree subnode parsing" patch.

Changes since v1:
- Submit as a stand-alone patch-set, rather then as part of a larger oob irq
  support patchset crossing multiple subsystems
- Add a patch to document the already existing practice of using slot subnodes
- Split of the dt bindings documentation for sdio-func child nodes into its
  own patch
- Add a preparation patch, setting slot_no where relevant
- And finally the "Add SDIO function devicetree subnode parsing" patch itself
  has been modified to look for the sdio function childnodes under a slot node
  instead of directly under the host node

Changes since v2:
- Drop the slot subnodes again, and drop the 2 slot subnodes patches

Regards,

Hans
