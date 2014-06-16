From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Jun 2014 19:56:43 +0200
Subject: [PATCH v2 0/4] brcmfmac: OOB interrupt support
Message-ID: <1402941407-8210-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of the brcmfmac: OOB interrupt support series.

Changes since v1:
-Post as a stand alone series, rather then together with sunxi pinctrl changes,
 etc.
-Add a patch to fixup the names of the register addresses used in the
 "brcmfmac: Fix OOB interrupt not working for BCM43362" patch
-Use the new register names in:
 "brcmfmac: Fix OOB interrupt not working for BCM43362"

Regards,

Hans
