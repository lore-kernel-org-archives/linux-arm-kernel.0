From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 5 Apr 2018 13:16:56 +0200
Subject: [PATCH] ARM: s3c24xx: mini2440: use device properties for at24
 eeprom
In-Reply-To: <20180404115147.16448-1-brgl@bgdev.pl>
References: <20180404115147.16448-1-brgl@bgdev.pl>
Message-ID: <CAJKOXPf5hhDp8igbCJhFbOxTkbFgCwrJum0nuV1yNF0seZUeTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2018 at 1:51 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
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

Looks ok, I will take it after merge window.

Best regards,
Krzysztof
