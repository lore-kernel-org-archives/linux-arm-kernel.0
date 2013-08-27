From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 27 Aug 2013 15:40:40 +0200
Subject: [Patch v2] pinctrl: Add s5pv210 support to pinctrl-exynos
In-Reply-To: <1377608890-8528-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1377608890-8528-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <3696905.8yvPmhxxxP@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mateusz,

On Tuesday 27 of August 2013 15:08:10 Mateusz Krawczuk wrote:
> This patch implements pinctrl support and adds device tree bindings
> for s5pv210.
>
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> ---
>  .../bindings/pinctrl/samsung-pinctrl.txt           |  3 +-
>  drivers/pinctrl/Kconfig                            |  2 +-
>  drivers/pinctrl/pinctrl-exynos.c                   | 58
> ++++++++++++++++++++++ drivers/pinctrl/pinctrl-samsung.c                
>  |  2 +
>  drivers/pinctrl/pinctrl-samsung.h                  |  1 +
>  5 files changed, 64 insertions(+), 2 deletions(-)

Acked-by: Tomasz Figa <t.figa@samsung.com>

As a side note, please write the PATCH keyword in the topic in upper case 
next time.

Best regards,
Tomasz
