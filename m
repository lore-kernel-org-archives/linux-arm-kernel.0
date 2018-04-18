From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Apr 2018 11:19:04 +0800
Subject: [PATCH 0/4] ARM: imx: use device properties for at24 eeprom
In-Reply-To: <20180404131627.9135-1-brgl@bgdev.pl>
References: <20180404131627.9135-1-brgl@bgdev.pl>
Message-ID: <20180418031903.GS25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 03:16:23PM +0200, Bartosz Golaszewski wrote:
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
> 
> This series converts all users of at24_platform_data to using generic
> device properties or - as is the case with PATCH 1/4 - drops the
> platform data entirely since it's not needed.
> 
> Bartosz Golaszewski (4):
>   ARM: imx: vpr200: drop at24_platform_data
>   ARM: imx: pcm043: use device properties for at24 eeprom
>   ARM: imx: pca100: use device properties for at24 eeprom
>   ARM: imx: pcm037: use device properties for at24 eeprom

Applied all, thanks.
