From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 31 Jan 2016 10:40:21 +0100
Subject: [linux-sunxi] [PATCH 0/3] mmc: sunxi: Support eMMC DDR modes
In-Reply-To: <1454088108-2332-1-git-send-email-wens@csie.org>
References: <1454088108-2332-1-git-send-email-wens@csie.org>
Message-ID: <56ADD685.1080006@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/29/2016 06:21 PM, Chen-Yu Tsai wrote:
> Hi everyone,
>
> This was "mmc: sunxi: Support vqmmc regulator and eMMC DDR modes". vqmmc
> support and DT patches were merged even though it was an RFC series, to
> my suprise.
>
> These are the remaining patches that add eMMC HS-DDR support to sunxi.
>
> Patch 1 adds timing delays for MMC_DDR52 mode.
>
> Patch 2 adds support for 8 bit eMMC DDR52 mode. Under this mode, the
> controller must run at twice the card clock, and different timing delays
> are needed.
>
> Patch 3 enables eMMC HS-DDR for sunxi-mmc.

All 3 patches look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
