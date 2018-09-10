From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 10 Sep 2018 17:59:17 +0200
Subject: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
In-Reply-To: <20180910151803.GX28860@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
Message-ID: <20180910155917.GB17956@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 04:18:03PM +0100, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> 
> for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> 
>   tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)

thanks for this.  I'll suck it into my tty-next branch to make it easier
for any future at91 serial driver changes to be simpler to merge.

greg k-h
