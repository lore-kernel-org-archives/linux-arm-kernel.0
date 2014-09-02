From: mporter@linaro.org (Matt Porter)
Date: Tue, 2 Sep 2014 11:31:41 -0400
Subject: [PATCH] ARM: configs: Remove REGULATOR_VIRTUAL_CONSUMER from
 defconfigs
In-Reply-To: <1409486590-23645-1-git-send-email-broonie@kernel.org>
References: <1409486590-23645-1-git-send-email-broonie@kernel.org>
Message-ID: <20140902153141.GB15771@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 31, 2014 at 01:03:10PM +0100, Mark Brown wrote:
> The virtual consumer is a test device intended to be used while developing
> regulator drivers, it should never be used in production. Remove it from
> all defconfigs to avoid confusion among users.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm/configs/bcm_defconfig      | 1 -

For bcm_defconfig:

Acked-by: Matt Porter <mporter@linaro.org>

-Matt
