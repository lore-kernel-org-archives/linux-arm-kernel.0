From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 07 Nov 2014 16:05:24 +0100
Subject: [PATCH v3 09/10] gpu: ipu-v3: Make use of media_bus_format enum
In-Reply-To: <1415369269-5064-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1415369269-5064-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415369269-5064-10-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415372724.29873.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 07.11.2014, 15:07 +0100 schrieb Boris Brezillon:
> In order to have subsytem agnostic media bus format definitions we've
> moved media bus definition to include/uapi/linux/media-bus-format.h and
> prefixed enum values with MEDIA_BUS_FMT instead of V4L2_MBUS_FMT.
> 
> Reference new definitions in the ipu-v3 driver.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
