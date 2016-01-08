From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 8 Jan 2016 20:16:58 +0800
Subject: [PATCH v2] soc: mediatek: SCPSYS: use builtin_platform_driver
In-Reply-To: <1451464240-5313-1-git-send-email-matthias.bgg@gmail.com>
References: <1451464240-5313-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CAGS+omCL8_RYs6PjHZhQG5gce4wWgnvTaBurOiLSfX3HMdcV6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Thanks for the patch...

On Wed, Dec 30, 2015 at 4:30 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
> SCPSYS can't be built as module. Use builtin_platform_driver instead.
> For this probe must not be __init and the data accessed can't be
> __initconst. Remove this macros. To make the impact as small as possible,
> fold scp_domain_data into scp_domain via a pointer.
>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Daniel Kurtz <djkurtz@chromium.org>
