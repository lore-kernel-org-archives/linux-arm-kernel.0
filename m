From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 09:56:17 +0100
Subject: [PATCH 06/10] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120509085617.GB28702@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 03:34:50AM +0530, Thomas Abraham wrote:

> +	s3c64xx_spi0_set_platdata("s3c6410-spi", NULL, 0, 1);

Shouldn't we just set the name in the struct platform_device rather than
requiring the machine to pass it through by hand?
