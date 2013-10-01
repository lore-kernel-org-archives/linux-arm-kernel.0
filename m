From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 1 Oct 2013 12:16:55 +0530
Subject: [PATCH 3/3] ARM: dts: Enable ahci sata and sata phy
In-Reply-To: <1380609183-21430-4-git-send-email-yuvaraj.cd@samsung.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
 <1380609183-21430-4-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <CAK9yfHy8XUpigc0VU_h-rCUUukirFALfnjQ5_aHzB-6O0UydEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuvaraj,

On 1 October 2013 12:03, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> This patch adds dt entry for ahci sata controller and its
> corresponding phy controller.phy node has been added w.r.t
> new generic phy framework.

[snip]
> +
> +               sata-phy {

Shouldn't this be sata-phy at 38?

> +                       compatible = "sata-phy-i2c";
> +                       reg = <0x38>;
> +               };

[snip]
> -       sata-phy at 12170000 {
> -               compatible = "samsung,exynos5-sata-phy";
> +       sata_phy:sata-phy at 12170000 {

nit: A space after sata_phy: would be good.


-- 
With warm regards,
Sachin
