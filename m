From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 29 Feb 2016 15:57:59 -0300
Subject: [PATCH 3/3] usb: musb: sunxi: support module autoloading
In-Reply-To: <1456104396-13282-3-git-send-email-emilio@elopez.com.ar>
References: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
 <1456104396-13282-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <CABxcv=nAUWfhHC-2jpTUHbk4PzyGL7D8jUJ33mXU0Aq7Xu7GAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Emilio,

On Sun, Feb 21, 2016 at 10:26 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> From: Emilio L?pez <emilio.lopez@collabora.co.uk>
>
> MODULE_DEVICE_TABLE() is missing, so the module isn't auto-loading on
> sunxi systems using the OTG controller. This commit adds the missing
> line so it loads automatically when building it as a module and running
> on a system with an USB OTG port.
>
> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
