From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 15:35:50 +0800
Subject: [PATCH] ARM: dts: fix the at24 compatible string in imx6q-h100
In-Reply-To: <20180124213148.4435-1-brgl@bgdev.pl>
References: <20180124213148.4435-1-brgl@bgdev.pl>
Message-ID: <20180205073548.GN31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 10:31:48PM +0100, Bartosz Golaszewski wrote:
> Using 'at24' as fallback is now deprecated - use the full
> 'atmel,<model>' string.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Applied, thanks.
