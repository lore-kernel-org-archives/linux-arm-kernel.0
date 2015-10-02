From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 03:15:11 -0700
Subject: [PATCH] pinctrl: sirf: Fix module autoloading for OF
In-Reply-To: <55F91F7C.3080102@osg.samsung.com>
References: <1442389425-27846-1-git-send-email-javier@osg.samsung.com>
 <55F91F7C.3080102@osg.samsung.com>
Message-ID: <CACRpkdYi+ecByw=54D0FZjwy6h_EX7wVQpaeAsCdUkD1NvF=EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 12:51 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> On 09/16/2015 09:43 AM, Javier Martinez Canillas wrote:
>> Drivers needs to export the OF id table and this be built into
>> the module or udev won't have the necessary information to auto
>> load the driver module when the device is registered by OF.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>
> Just found out that PINCTRL_SIRF is a boolean Kconfig symbol and not
> a tristate one so it can't be built as a module. Sorry for the noise.

OK dropping this.

Yours,
Linus Walleij
