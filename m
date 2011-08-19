From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 16:13:02 +0900
Subject: enable two usb host on s3c2416 processor
In-Reply-To: <loom.20110819T071755-841@post.gmane.org>
References: <loom.20110819T071755-841@post.gmane.org>
Message-ID: <000001cc5e3f$6f776cf0$4e6646d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GIGIN JOSE wrote:
> 
> Hi,
> 
Hi

> I am using ARM9 based s3c2416 processor. The SoC has one USB host
> controller and one USB host/device controller. What are the
> register settings that should be done to enable both USB
> interfaces as USB host controller. ? There is a register PHYCTRL
>  with address 0x4C00_0080. Its bit[0] says something on USB host
>  mode and USB device mode. Is it this register which I should
> work on or any more register configurations are required ?

(Cc'ed Kyoungil Kim)

As I know, your setting is right, but you need to connect (serial
interface) between USB2.0 PHY and USB 1.1 Host on board.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
