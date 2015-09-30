From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 30 Sep 2015 13:57:10 +0900
Subject: [PATCH v2] nouveau: arm: Add MODULE_FIRMWARE for gk20a
In-Reply-To: <1443452893-18246-1-git-send-email-kwizart@gmail.com>
References: <1443452893-18246-1-git-send-email-kwizart@gmail.com>
Message-ID: <CAAVeFuJLJO4LvLqq2w9gMe6V6L3VDi+Gz59GvwKF2v8OWTWgBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 12:08 AM, Nicolas Chauvet <kwizart@gmail.com> wrote:
> This patch is needed by initramfs tools to detect
> the required firmware files for the module.
>
> This patch tests for either TEGRA_124_SOC or TEGRA_132_SOC
> for the firmwares related to the Tegra K1 generation.
>
> v2: move the MODULE_FIRMWARE to the nvidia_platform.c file.
>  This will avoid to test for NOUVEAU_PLATFORM_DRIVER

Nice, thanks for doing this change!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
