From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 19 Jan 2015 14:05:11 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Add simplefb nodes for lcd and vga output
Message-ID: <1421672712-13298-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

When the simplefb dt node fix for 3.19 which I just posted lands, the
"ARM: dts: sunxi: Add simplefb nodes for de_be0-lcd0, de_be0-lcd0-tve0 pipelines"
you've currently queued up will no longer apply due to a conflict in
sun4i-a10.dtsi .

Here is a v2 of said patch fixing the conflict, it also changes the
added simplefb nodes on _sun4i_ to be of the de_fe0-de_be0-lcd* variant rather
then of the de_be0-lcd* variant. We can safely make this change since no
official u-boot release using the de_be0-lcd* variants was ever done.

Please drop v1 of this patch from your queue and use this one instead.

Thanks,

Hans
