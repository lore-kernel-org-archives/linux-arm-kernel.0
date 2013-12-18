From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 18 Dec 2013 16:01:36 +0100
Subject: [PATCH v2 1/1] ARM: dts: add board dts file for EXYNOS4412 based
 TINY4412 board
In-Reply-To: <1387373039-4738-1-git-send-email-kasimling@gmail.com>
References: <1387373039-4738-1-git-send-email-kasimling@gmail.com>
Message-ID: <1486025.NpqSQkmkfm@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Wednesday 18 of December 2013 21:23:59 Alex Ling wrote:
> Add a minimal board dts file for EXYNOS4412 based FriendlyARM's
> TINY4412 board. This patch including support peripherals like
> UART, SD card on SDMMC2 port and GPIO connected LEDs.
> 
> Signed-off-by: Alex Ling <kasimling@gmail.com>
> ---
> Changes for v2:
>   - Clean up patch description
>   - Fix LED labels as Tomasz's suggested
>   - Fix style issues
> 
>  arch/arm/boot/dts/Makefile                |    1 +
>  arch/arm/boot/dts/exynos4412-tiny4412.dts |   93 +++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-tiny4412.dts

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
