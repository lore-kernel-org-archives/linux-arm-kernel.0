From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 19 Sep 2011 16:44:55 +0800
Subject: [PATCH 36/62] i2c: irq: Remove IRQF_DISABLED
In-Reply-To: <1315383059-3673-37-git-send-email-yong.zhang0@gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-37-git-send-email-yong.zhang0@gmail.com>
Message-ID: <CAGsJ_4z8_zx3dATD+F8A0Krw0N0REBTdzD3NiHFOU9P5h0Reuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/7 Yong Zhang <yong.zhang0@gmail.com>:
> This flag is a NOOP and can be removed now.
>
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Acked-by: Barry Song <21cnbao@gmail.com>

> ---
> ?drivers/i2c/busses/i2c-bfin-twi.c ? | ? ?4 ++--
> ?drivers/i2c/busses/i2c-designware.c | ? ?2 +-
> ?drivers/i2c/busses/i2c-highlander.c | ? ?2 +-
> ?drivers/i2c/busses/i2c-nomadik.c ? ?| ? ?2 +-
> ?drivers/i2c/busses/i2c-nuc900.c ? ? | ? ?2 +-
> ?drivers/i2c/busses/i2c-pmcmsp.c ? ? | ? ?2 +-
> ?drivers/i2c/busses/i2c-s3c2410.c ? ?| ? ?2 +-
> ?drivers/i2c/busses/i2c-sh7760.c ? ? | ? ?2 +-
> ?drivers/i2c/busses/i2c-sh_mobile.c ?| ? ?2 +-
> ?drivers/i2c/busses/i2c-stu300.c ? ? | ? ?2 +-
> ?10 files changed, 11 insertions(+), 11 deletions(-)
