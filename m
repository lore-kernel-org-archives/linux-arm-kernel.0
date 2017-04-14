From: jic23@kernel.org (Jonathan Cameron)
Date: Fri, 14 Apr 2017 15:30:31 +0100
Subject: [GIT PULL] Immutable branch between MFD and IIO due for the v4.12
 merge window
In-Reply-To: <20170411100528.2zif3fyi7uoyw33n@dell>
References: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
 <20170411100528.2zif3fyi7uoyw33n@dell>
Message-ID: <0f30afec-ff42-e125-96d6-35893324f7ef@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/17 11:05, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-v4.12
> 
> for you to fetch changes up to f2499ab450d3052097ba53a7d763f767935c0c59:
> 
>   iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs (2017-04-11 11:02:33 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and IIO due for the v4.12 merge window
> 
> ----------------------------------------------------------------
> Quentin Schulz (1):
>       iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
> 
>  drivers/iio/adc/Kconfig      |  10 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/axp20x_adc.c | 617 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 628 insertions(+)
>  create mode 100644 drivers/iio/adc/axp20x_adc.c
> 
Hi Lee, 

Thanks for doing this, but the reason it was going to go through your
tree in the first place was a dependency on
commit 4707274714ef ("mfd: axp20x: Correct name of temperature data ADC registers")

Not present in the immutable branch.

There isn't much time for anything else going on around this driver though
so other than a possible merge conflict on the Kconfig and Makefile shouldn't
matter if this just goes through mfd. (famous last words ;)

Jonathan
