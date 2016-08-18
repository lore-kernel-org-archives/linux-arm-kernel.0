From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 18 Aug 2016 20:02:14 +0200
Subject: [PATCH v2 0/3] ARM: dts: sun6i: tablet dts changes
Message-ID: <1471543337-6938-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime and Chen-Yu,

Here is a v2 of the series I sent earlier today, changes:

-Add a 3th patch (patch 1/3) which I forgot in v1, the other
 2 patches actually depend on this one to apply without conflicts
-Name the added dtsi file sun6i-reference-design-tablet.dtsi instead
 of sun6i-a31-reference-design-tablet.dtsi, to be consistent with
 what we've done for sun5i / sun8i (and because it is valid for
 both A31 and A31s based tablets).

Regards,

Hans
