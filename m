From: swarren@nvidia.com (Stephen Warren)
Date: Sat, 24 Nov 2012 10:48:51 -0700
Subject: [PATCH] gpiolib: rename pin range arguments
In-Reply-To: <1353484243-6115-1-git-send-email-linus.walleij@stericsson.com>
References: <1353484243-6115-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50B10883.5040101@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 12:50 AM, Linus Walleij wrote:
> To be crystal clear on what the arguments mean in this
> funtion dealing with both GPIO and PIN ranges with confusing
> naming, we now have gpio_offset and pin_offset and we are
> on the clear that these are offsets into the specific GPIO
> and pin controller respectively. The GPIO chip itself will
> of course keep track of the base offset into the global
> GPIO number space.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
