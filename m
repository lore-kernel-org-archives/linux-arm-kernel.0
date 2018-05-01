From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 May 2018 08:16:31 -0700
Subject: [PATCH] ARM: omap1: osk: use device properties for at24 eeprom
In-Reply-To: <20180404123822.5664-1-brgl@bgdev.pl>
References: <20180404123822.5664-1-brgl@bgdev.pl>
Message-ID: <20180501151631.GL5671@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bartosz Golaszewski <brgl@bgdev.pl> [180404 05:39]:
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
> 
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Applying into omap-for-v4.18/omap1 thanks.

Tony
