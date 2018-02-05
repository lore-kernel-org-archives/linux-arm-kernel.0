From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 15:35:27 +0800
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for imx6qdl-rex
In-Reply-To: <20180124213116.4375-1-brgl@bgdev.pl>
References: <20180124213116.4375-1-brgl@bgdev.pl>
Message-ID: <20180205073526.GM31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 10:31:16PM +0100, Bartosz Golaszewski wrote:
> Using 'at' as the <manufacturer> part of the compatible string is now
> deprecated. Use a correct string: 'atmel,<model>'.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Applied, thanks.
