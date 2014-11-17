From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 17 Nov 2014 12:34:44 +0100
Subject: [PATCH 0/2] dt-bindings: simplefb: Drop the advice about using a
 specific path for nodes
Message-ID: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Review of the u-boot sunxi simplefb patches has lead to the decision that
u-boot should not use a specific path to find the nodes as this goes contrary
to how devicetree usually works.

Instead a platform specific compatible + properties should be used for this.

This series updates the simplefb bindings reflect this.

Regards,

Hans
