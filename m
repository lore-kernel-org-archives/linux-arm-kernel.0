From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 04 Aug 2016 13:49:10 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAyLzJdIGlteDUzLmR0c2kgOiBBZGQgRE1BIGNvbmZp?=
 =?UTF-8?B?Z3VyYXRpb24gZm9yIFVBUlQ=?=
In-Reply-To: <1470306157-11181-2-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <CAOMZO5BoRsrHv-+5c9bAXO2NCya8sPqmmpy9DOfav6NvQ+VMLQ@mail.gmail.com>
 <1470306157-11181-1-git-send-email-fabien.lahoudere@collabora.co.uk>
 <1470306157-11181-2-git-send-email-fabien.lahoudere@collabora.co.uk>
Message-ID: <1470307750.712399023@f361.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>???????,  4 ??????? 2016, 13:22 +03:00 ?? Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>:
>
>In order to use sdma with UART, we need to add DMA configuration in device tree.
>
>Signed-off-by: Fabien Lahoudere < fabien.lahoudere@collabora.co.uk >
>---
>?arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
>?1 file changed, 10 insertions(+)
...

Hello.

UART SDMA has been tested by me for i.MX51.
So, on my opinion, In the first part of the patch, we just need to remove is_imx6q_uart()
check on and always let the devicetree decide about DMA usage.

Thanks.
---
