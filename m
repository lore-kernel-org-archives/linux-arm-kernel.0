From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 4 Nov 2017 12:39:57 +0100
Subject: [PATCH v2 3/3] tty: serial: imx: remove imx_disable_rx_int
In-Reply-To: <20171020212021.13065-3-troy.kisky@boundarydevices.com>
References: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
 <20171020212021.13065-3-troy.kisky@boundarydevices.com>
Message-ID: <20171104113957.GA10523@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 02:20:21PM -0700, Troy Kisky wrote:
> Since imx_disable_rx_int is only called by imx_startup,
> let's integrate it into that function.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
> v2: new patch
> ---
>  drivers/tty/serial/imx.c | 39 ++++++++++-----------------------------
>  1 file changed, 10 insertions(+), 29 deletions(-)

Does not apply :(
