From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Apr 2017 15:53:06 +0200
Subject: [PATCH v6 2/2] mmc: host: s3cmci: allow probing from device tree
In-Reply-To: <1491004256-13969-3-git-send-email-sergio.prado@e-labworks.com>
References: <1491004256-13969-1-git-send-email-sergio.prado@e-labworks.com>
 <1491004256-13969-3-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <CAPDyKFqLKj5pyZpaN3VmMGT+5W1Vg9u=UgPuv=+B6ejCBwTMdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 April 2017 at 01:50, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> Allows configuring Samsung S3C24XX MMC/SD/SDIO controller using a device
> tree.
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>

Thanks, applied for next - however, by amending the change with the
fix from Arnd. See more below.

[...]

> +
> +       if (pdata->wprotect_invert);

The above semicolon is removed to fix the expression.

> +               mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> +

[...]

Kind regards
Uffe
