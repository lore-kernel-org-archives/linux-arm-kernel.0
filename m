From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 29 Dec 2014 16:33:30 +0100
Subject: [PATCH 0/3] add Atmel EBI (External Bus Interface) DT nodes for
 AT91SAM9263
In-Reply-To: <1418979100-13243-1-git-send-email-alexanders83@web.de>
References: <1418979100-13243-1-git-send-email-alexanders83@web.de>
Message-ID: <20141229163330.050f6b60@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Fri, 19 Dec 2014 09:51:37 +0100
Alexander Stein <alexanders83@web.de> wrote:

> This is based on and requires Boris' work on an EBI driver for AT91. Please
> refer to https://lkml.org/lkml/2014/12/3/806.
> The reason I added no pinctrl is that those pins from EBI1 in my case are not
> muxable. They are fixed so there is nothing I can test here.
> I used this patchset and the EBI to configure a PSRAM to be used by the
> atmel_lcdfb driver which works so far.
> This also means EBI0 is rather untested, but it should behave like EBI1 if
> the numbers are correct.

Thanks for your patches.
Unless there are other changes in the EBI/SMC bindings (which I'm not
sure since the EBI driver has not been accepted yet) you have my

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
