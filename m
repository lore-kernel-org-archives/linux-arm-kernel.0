From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Nov 2018 17:50:19 +0530
Subject: [PATCH 00/12] ARM: davinci: fix GPIO breakage after v4.19
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
Message-ID: <6eb91ecb-47b1-8f77-afcc-9ace3cb15b82@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On 21/11/18 3:05 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is the entire set of changes needed to fix the broken GPIO support
> for DaVinci boards in legacy mode after certain changes made to the
> GPIO driver in 4.19, namely: commits 587f7a694f01 ("gpio: davinci: Use
> dev name for label and automatic base selection") and eb3744a2dd01
> ("gpio: davinci: Do not assume continuous IRQ numbering").

I applied this series and sent a pull request to ARM SoC too.

Thanks,
Sekhar
