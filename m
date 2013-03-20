From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Mar 2013 10:36:50 -0300
Subject: [PATCH 1/2] ARM: mach-pca100: Add CONFIG_USB_ULPI dependency
In-Reply-To: <20130320062026.GD25876@arwen.pp.htv.fi>
References: <1363743553-17295-1-git-send-email-festevam@gmail.com>
 <20130320062026.GD25876@arwen.pp.htv.fi>
Message-ID: <CAOMZO5C85WjtWLrk_EPnH=9sGMkkURkEu-EAzd-3yTgQtuAnng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 3:20 AM, Felipe Balbi <balbi@ti.com> wrote:

> how about just providing a static inline nop on <linux/usb/ulpi.h> ??

Good idea. Just sent a patch doing this to the linux-usb list.

Thanks,

Fabio Estevam
