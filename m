From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Apr 2017 15:08:16 +0100
Subject: [GIT PULL] pinctrl: samsung: Stuff for v4.12
In-Reply-To: <20170408142050.1164-2-krzk@kernel.org>
References: <20170408142050.1164-1-krzk@kernel.org>
 <20170408142050.1164-2-krzk@kernel.org>
Message-ID: <20170411140816.3al2ge7zsskswmaq@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 08 Apr 2017, Krzysztof Kozlowski wrote:

> Hi,
> 
> Update for v4.12. Marek's commits were also shared (as separate sub-tag) to MFD
> (Lee Jones) for his work (it is a dependency).

I already pulled Marek's patches into MFD.

What are Charles' patches for?

> Cc: Lee Jones <lee.jones@linaro.org>
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-4.12
> 
> for you to fetch changes up to f69ae4f58a198ad15b0422637434d2bcf6fc2e2a:
> 
>   pinctrl: samsung: Use devres version of gpiochip_add_data (2017-03-23 21:13:19 +0200)
> 
> ----------------------------------------------------------------
> Samsung pinctrl drivers update for v4.12:
> 1. Add support for pad retention control through pinctrl drivers which
>    moves us forward to better runtime PM of pinctrl, clocks, power domains
>    and other devices.
> 2. Fix GPIO hogs by registering pinctrl before registering gpiolib.
> 3. Use devm-like interface.
> 
> ----------------------------------------------------------------
> Charles Keepax (2):
>       pinctrl: samsung: Register pinctrl before GPIO
>       pinctrl: samsung: Use devres version of gpiochip_add_data
> 
> Marek Szyprowski (2):
>       pinctrl: samsung: Ensure that pad retention is disabled on driver init
>       pinctrl: samsung: Add support for pad retention control for Exynos5433 SoCs
> 
>  drivers/pinctrl/samsung/pinctrl-exynos.c  | 63 +++++++++++++++++++++++++++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 45 ++++++++++------------
>  2 files changed, 83 insertions(+), 25 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
