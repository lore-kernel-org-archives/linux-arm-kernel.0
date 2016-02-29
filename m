From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 29 Feb 2016 15:55:38 -0300
Subject: [PATCH 1/3] [media] rc: sunxi-cir: support module autoloading
In-Reply-To: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
References: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <CABxcv=kQ=5P6-4aNi7uNu=EmHSp0=cE+8u+98bEmRV9VqH-u7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Emilio,

On Sun, Feb 21, 2016 at 10:26 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> From: Emilio L?pez <emilio.lopez@collabora.co.uk>
>
> MODULE_DEVICE_TABLE() is missing, so the module isn't auto-loading on
> systems supporting infrared. This commit adds the missing line so it
> works out of the box when built as a module and running on a sunxi
> system with an infrared receiver.
>
> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
