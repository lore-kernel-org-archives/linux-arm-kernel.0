From: vladoman@gmail.com (Vladimir Pantelic)
Date: Tue, 26 Apr 2011 08:37:35 +0200
Subject: [PATCH v16 01/13] davinci vpbe: V4L2 display driver for DM644X SoC
In-Reply-To: <1301737249-4012-1-git-send-email-manjunath.hadli@ti.com>
References: <1301737249-4012-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4DB6682F.2010109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manjunath Hadli wrote:
> This is the display driver for Texas Instruments's DM644X family
> SoC. This patch contains the main implementation of the driver with the
> V4L2 interface. The driver implements the streaming model with
> support for both kernel allocated buffers and user pointers. It also
> implements all of the necessary IOCTLs necessary and supported by the
> video display device.

is there any hope/chance to make this share code with the omap v4l2
driver in drivers/media/video/omap?
