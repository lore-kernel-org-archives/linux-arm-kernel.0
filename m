From: cjb@laptop.org (Chris Ball)
Date: Fri, 12 Apr 2013 14:19:15 -0400
Subject: [PATCH v5] mmc: dw_mmc: let device core setup the default pin
 configuration
In-Reply-To: <1365683047-8829-1-git-send-email-thomas.abraham@linaro.org>
 (Thomas Abraham's message of "Thu, 11 Apr 2013 17:54:07 +0530")
References: <1365683047-8829-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <87y5cnehng.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 11 2013, Thomas Abraham wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> Changes since v4:
> - Fixed the incorrecr return path after error in enabling vmmc regulator
>   as pointed out by Doug.

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
