From: cjb@laptop.org (Chris Ball)
Date: Fri, 22 Mar 2013 12:33:33 -0400
Subject: [PATCH] mmc: sdhci-s3c: let device core setup the default pin
 configuration
In-Reply-To: <CACRpkdY-RVAXxc2TqDcczhCLGDC8d401ucuCCDzRb+Ha9apr8g@mail.gmail.com>
 (Linus Walleij's message of "Thu, 7 Mar 2013 09:09:58 +0100")
References: <1362569776-13932-1-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdY-RVAXxc2TqDcczhCLGDC8d401ucuCCDzRb+Ha9apr8g@mail.gmail.com>
Message-ID: <87y5dfo0ma.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 07 2013, Linus Walleij wrote:
> On Wed, Mar 6, 2013 at 12:36 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>
>> With device core now able to setup the default pin configuration,
>> the call to devm_pinctrl_get_select_default can be removed. And
>> the pin configuration code based on the deprecated Samsung specific
>> gpio bindings is also removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
