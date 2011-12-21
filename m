From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Dec 2011 15:59:26 -0200
Subject: [PATCH] arm: device.h: Add dma_mask to pdev_archdata structure
In-Reply-To: <4EF0359C.1090703@googlemail.com>
References: <1321415178-12179-1-git-send-email-festevam@gmail.com>
 <4EF0359C.1090703@googlemail.com>
Message-ID: <CAOMZO5BOYRKz9uVrhe43q9SxGdyELPGktWVNks=vcXb2MZnYAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dirk,

On Tue, Dec 20, 2011 at 5:13 AM, Dirk Behme <dirk.behme@googlemail.com> wrote:

> Will there ?be a v2 of this patch fixing the review comments?
>
> It seems the number of people hit by the issue this patch deals with
> increases ...

I no longer see this issue on a recent kernel.

drivers/usb/host/fsl-mph-dr-of.c is not built for i.MX now.

If you still see this issue, let me know how to reproduce it.

Regards,

Fabio Estevam
