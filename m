From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 9 May 2012 21:40:26 +0800
Subject: [PATCH 05/10] ARM: Samsung: Update the device names for spi clock
 lookup
In-Reply-To: <20120509085249.GA28702@sirena.org.uk>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
 <20120509085249.GA28702@sirena.org.uk>
Message-ID: <CAJuYYwQ+Wn11puF7AdPD41Jntbuj7oZHqNfzQA2T8V=2cigQnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2012 16:52, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 09, 2012 at 03:34:49AM +0530, Thomas Abraham wrote:
>> With the addition of platform specific driver data in the spi-s3c64xx
>> driver, the device name of spi controllers are changed. Accordingly,
>> update the device name of spi clocks instances.
>
> This should've been squashed into the patch that updated to use driver
> data in order to avoid breaking bisection.

This patch updates clock devname in the platform code and the
modifications to use driver data is in the driver file. So these two
changes are kept separate to allow them to be applied to their
respective trees.

Thanks,
Thomas.
