From: girishks2000@gmail.com (Girish KS)
Date: Thu, 30 May 2013 10:55:04 +0530
Subject: [PATCH v1 0/3] Polling support for s3c64xx spi controller
In-Reply-To: <1369032694-13183-1-git-send-email-ks.giri@samsung.com>
References: <1369032694-13183-1-git-send-email-ks.giri@samsung.com>
Message-ID: <CAKrE-KcRNRJ-U_qR8UnVa1TJ6dJAF9ZDmuUX5dBOM3XxvOPZZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Can you please check the performance with this patch set

On Mon, May 20, 2013 at 12:21 PM, Girish K S <girishks2000@gmail.com> wrote:
> This patch series adds support for the polling mode only. Also 2nd patch
> in the series adds support for dedicated cs pin. After Thomas's patch for
> using default gpio is merged(commit id: 00ab539), one of the patch in this
> series is dropped and new series is generated.
>
> Girish K S (3):
>   spi: s3c64xx: added support for polling mode
>   spi: s3c64xx: Added provision for dedicated cs pin
>   spi: s3c64xx: Added support for exynos5440 spi
>
>  drivers/spi/spi-s3c64xx.c |  197 ++++++++++++++++++++++++++++++++-------------
>  1 files changed, 140 insertions(+), 57 deletions(-)
>
> --
> 1.7.5.4
>
