From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 21 Mar 2016 21:33:46 -0300
Subject: [PATCH] musb: sunxi-glue: Fix sunxi-musb driver not auto-loading
In-Reply-To: <1458598418-16959-1-git-send-email-hdegoede@redhat.com>
References: <1458598418-16959-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CABxcv=kwLOr_GTk_BNodyhd37TJF5iRONWnnX_WCoM-4_PYLAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 7:13 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add a missing MODULE_DEVICE_TABLE() line which was causing the
> sunxi-musb glue to not auto-load when build as a module.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
