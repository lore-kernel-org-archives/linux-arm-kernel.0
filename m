From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Jun 2016 01:39:55 +0200
Subject: [PATCH v2 0/11] Changes to support 150 MHz eMMC on rk3399
In-Reply-To: <1465859076-4868-1-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Message-ID: <2340840.IUG4rtlpvT@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. Juni 2016, 16:04:24 schrieb Douglas Anderson:
> The theme of this series of patches is to try to allow running the eMMC
> at 150 MHz on the rk3399 SoC, though the changes should still be correct
> and have merit on their own.  The motivation for running at 150 MHz is
> that doing so improves signal integrity and (with some eMMC devices)
> doesn't affect throughput.
> 
> These patches have been structured to keep things as separate as
> possible, but nevertheless there are still some dependencies between
> patches.  It probably makes the most sense for all of the non-device
> tree patches to go through a single tree.  If others agree, perhaps the
> most sane would be to get Acks from PHY maintainers and then to land the
> patches in the MMC tree.  Device tree patches should be able to be
> landed separately and the worst what would happen is a warning in the
> kernel log if you have the code without the device tree.

while my evaluation board does not seem to have an enhanced strobe emmc, it 
nevertheless still runs fine with these patches applied, for the series 
(including the separate v2.1) on a rk3399-evb:

Tested-by: Heiko Stuebner <heiko@sntech.de>
