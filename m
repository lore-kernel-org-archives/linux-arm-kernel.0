From: broonie@kernel.org (Mark Brown)
Date: Sat, 28 Sep 2013 23:56:14 +0100
Subject: [PATCH 4/5] ASoC: samsung: Use CONFIG_ARCH_S3C64XX to check for
 S3C64xx support
In-Reply-To: <1380392497-27406-4-git-send-email-tomasz.figa@gmail.com>
References: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
 <1380392497-27406-4-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130928225614.GR19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 28, 2013 at 08:21:36PM +0200, Tomasz Figa wrote:
> Since CONFIG_PLAT_S3C64XX is going to be removed, this patch modifies
> the s3c-i2s-v2 driver to use the proper way of checking for S3C64xx
> support - CONFIG_ARCH_S3C64XX.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130928/a30b6c70/attachment.sig>
