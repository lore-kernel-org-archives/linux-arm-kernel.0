From: dianders@google.com (Doug Anderson)
Date: Wed, 30 Jul 2014 08:58:53 -0700
Subject: [PATCHv8 1/5] mmc: dw_mmc: modify the dt-binding for removing
 slot-node and supports-highspeed
In-Reply-To: <1406718310-32078-2-git-send-email-jh80.chung@samsung.com>
References: <1406718310-32078-1-git-send-email-jh80.chung@samsung.com>
 <1406718310-32078-2-git-send-email-jh80.chung@samsung.com>
Message-ID: <CAD=FV=UE38OaZurcNXnoh2SdKVz=xXGA83+FFDQKW+rP-HqMpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaehoon,

On Wed, Jul 30, 2014 at 4:05 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Almost SoCs use one slot per host controller.
> (Even if controller can support the multiple slot, Recommend to use one slot per host controller.)
> Don't use the slot-node and deprecate the "supports-highspeed" property.
> Instead, use the cap-mmc/sd-highspeed.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Reviewed-by: Doug Anderson <dianders@chromium.org>
