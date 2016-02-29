From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 29 Feb 2016 15:56:50 -0300
Subject: [PATCH 2/3] dmaengine: sun4i: support module autoloading
In-Reply-To: <1456104396-13282-2-git-send-email-emilio@elopez.com.ar>
References: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
 <1456104396-13282-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <CABxcv=n_119K-9ntCXeUOm86GSz42sn1QmoGHedBa0f7X1vk2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Emilio,

On Sun, Feb 21, 2016 at 10:26 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> From: Emilio L?pez <emilio.lopez@collabora.co.uk>
>
> MODULE_DEVICE_TABLE() is missing, so the module isn't auto-loading on
> supported systems. This commit adds the missing line so it loads
> automatically when building it as a module and running on a system
> with the early sunxi DMA engine.
>
> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
