From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Oct 2013 12:13:44 -0600
Subject: [PATCH 0/7] ARM: tegra: basic support for Tegra124 SoC
In-Reply-To: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
Message-ID: <5252F9D8.5010105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 01:31 AM, Joseph Lo wrote:
> Hi,
> 
> This series adds basic support for the new Tegra SoC, Tegra124. To bring
> up the system, it also needs an initrd as rootfs. Because most of the
> peripheral not be enabled yet in this series, it depends on the clock and
> pinctrl driver.

Great. I tested these and they work fine for me too, even using bootz
rather than bootm after fixing some bootz issues in our internal Venice2
U-Boot.

If you post V2, I'll apply it ASAP!
