From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Dec 2015 14:16:09 +0900
Subject: [PATCH v9 0/4] Exynos SROMc configuration and Ethernet support for
 SMDK5410
In-Reply-To: <cover.1447659546.git.p.fedin@samsung.com>
References: <cover.1447659546.git.p.fedin@samsung.com>
Message-ID: <56724519.80108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.11.2015 16:43, Pavel Fedin wrote:
> This patch extends Exynos SROM controller driver with ability to configure
> controller outputs and enables SMSC9115 Ethernet chip on SMDK5410 board,
> which is connected via SROMc bank #3.
> 
> With this patchset, support for the whole existing SMDK range can be added.
> Actually, only bank number is different.
> 
> This patchset also depends on Exynos 5410 pinctrl support, introduced by
> patches 0003 and 0004 from this set:
> [PATCH v4 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330862.html
> 
> Pinctrl support is necessary in order to correctly configure
> multifunctional pins of the Exynos chip.
> 

Let me share the plan/status:
1. Currently Kukjin Kim is out of office (he told me he will be back on
Christmas).
2. I asked arm-soc people to pull my previous pull requests.

3. I applied this patchset to my branch:
next/stuff-late-not-split-per-branch
https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=next/stuff-late-not-split-per-branch

4. This branch is not pushed to linux-next. I will sort it out if my
previous pull requests get in. I will be out of office for Christmas so
depending on the timing of {arm-soc,Christmas,Kukjin} this may or may
not go into v4.5 (yay...).

5. If it does not get into v4.5, I will rebase it and proceed further
for v4.6.

If you have any questions, please let me know.

Best regards,
Krzysztof
