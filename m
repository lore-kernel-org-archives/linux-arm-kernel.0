From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 15:35:03 +0800
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for
 imx6qdl-zii-rdu2
In-Reply-To: <20180124212823.4164-1-brgl@bgdev.pl>
References: <20180124212823.4164-1-brgl@bgdev.pl>
Message-ID: <20180205073502.GL31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 10:28:23PM +0100, Bartosz Golaszewski wrote:
> Using 'at' as the <manufacturer> part of the compatible string is now
> deprecated. Use a correct string: 'atmel,<model>'.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Applied, thanks.
