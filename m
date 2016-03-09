From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  9 Mar 2016 20:38:58 +0100
Subject: [PATCH 0/1] ARM: dts: sun8i-q8-common: Do not set constraints on dc1sw
Message-ID: <1457552339-400-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, Chen-yu,

As I mailed you about a week ago, I was having problems getting
linux-sunxi/sunxi-next to boot on sun8i q8 tablets because of
the new axp223 regulator support. This patch fixes things for me.

I'm not 100% sure this is the right solution, but I could not find
another way, and the fix is harmless since we also constrain dcdc1
itself to the same values as the constrains we are now removing
from dc1sw.

Regards,

Hans
