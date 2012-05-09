From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 09:52:49 +0100
Subject: [PATCH 05/10] ARM: Samsung: Update the device names for spi
 clock lookup
In-Reply-To: <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120509085249.GA28702@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 03:34:49AM +0530, Thomas Abraham wrote:
> With the addition of platform specific driver data in the spi-s3c64xx
> driver, the device name of spi controllers are changed. Accordingly,
> update the device name of spi clocks instances.

This should've been squashed into the patch that updated to use driver
data in order to avoid breaking bisection.
