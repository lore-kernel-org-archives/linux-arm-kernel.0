From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 21:21:02 +0000
Subject: [PATCH 04/11] misc: Versatile Express display muxer driver
In-Reply-To: <1346689531-7212-5-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-5-git-send-email-pawel.moll@arm.com>
Message-ID: <201209032121.03306.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 September 2012, Pawel Moll wrote:
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/vexpress.txt |   19 ++
>  drivers/misc/vexpress/Makefile                     |    1 +
>  drivers/misc/vexpress/display.c                    |  197 ++++++++++++++++++++
>  3 files changed, 217 insertions(+)
>  create mode 100644 drivers/misc/vexpress/display.c
> 

Shouldn't this go into the drivers/video directory?

	Arnd
