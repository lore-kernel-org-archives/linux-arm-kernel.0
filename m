From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 5 Apr 2013 15:57:17 +0200
Subject: Regarding the SPI initialization problem on sam9x5 2000 boards
 in linux kernel 3.2.6
In-Reply-To: <48262.115.249.69.209.1365160782.squirrel@mail.siennaecad.com>
References: <48262.115.249.69.209.1365160782.squirrel@mail.siennaecad.com>
Message-ID: <515ED83D.3010504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 01:19 PM, sambasiva.a at siennaecad.com :
> Hi,
> 
> when i execute the following command the sam9x5 2000 board will hang.
> 
> echo "test" > /dev/spidev0.1
> I am facing this problem once  ported the sam9x5 code from 2.6.39 to 3.2.6
> kernel .
> 
> Could you please tell me anyone how to move out from the hang state.

You can test the consolidated 3.6 based kernel that we are deploying on
our github tree: branch: linux-3.6.9-at91

https://github.com/linux4sam/linux-at91/commits/linux-3.6.9-at91

The SPI code is being review on this mainling list: search for the
following patch series:

"spi/spi-atmel: add dmaengine support for atmel spi controller and to
test the device tree support"

Best regards,
-- 
Nicolas Ferre
