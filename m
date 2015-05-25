From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 25 May 2015 16:24:32 +0200
Subject: [REGRESSION] No serial console output on BeagleBone Black
Message-ID: <CAMpxmJVhoWtyzhNBrnyYaiJSa_kSL_HQsJfbWQm5CQGTPac7=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

I tried booting a BeagleBone Black Rev C with current git, but got no
output after u-boot's "Starting kernel ...". Bisect points at commit
e3bc5358 ARM: dts: am33xx: add minimal l4 bus layout with control
module support. Let me know if you need any more info.

Best regards,
Bartosz Golaszewski
