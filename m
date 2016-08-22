From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 10:21:03 -0600
Subject: [PATCH V3 0/5] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <47b64ef5-c75b-e60a-81b4-63f91464333b@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2016 09:09 AM, Stefan Wahren wrote:
> This patch series add support for Raspberry Pi Zero with USB host mode. It's
> based on the patch "ARM64: dts: bcm: Use a symlink to R-Pi dtsi files
> from arch=arm" from Ian Campbell. Currently there is a bug [1] which needs
> to fixed before because after applying these patch series the bug isn't
> reproducible anymore but not fixed.
>
> The patches 1-3 fixes the USB DT settings for bcm283x. Patch 3 is only compile
> tested, so it would be nice if someone with a RPi 3 could test it.
> The last patch based on the work of Lubomir Rintel [2] and Noralf Tr?nnes [3].
>
> Note: Patch 3 can't be cherry-picked because it depends on Patch 2.

All looks reasonable to me at a quick glance. I didn't validate any of 
the GPIO values etc.

The series,
Acked-by: Stephen Warren <swarren@nvidia.com>
