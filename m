From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Aug 2017 11:50:37 +0200
Subject: [PATCH v3 2/2] serial: 8250: of: Add new port type for MediaTek
 BTIF controller on MT7622/23 SoC
In-Reply-To: <f773843daf6844be7b942185bafcb91304b75f7f.1503248851.git.sean.wang@mediatek.com>
References: <cover.1503248851.git.sean.wang@mediatek.com>
 <f773843daf6844be7b942185bafcb91304b75f7f.1503248851.git.sean.wang@mediatek.com>
Message-ID: <CAK8P3a0GWir3RxQug4C0hmO-_-nki7UY8Bd1a1XR=LN_mK_9zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 20, 2017 at 7:17 PM,  <sean.wang@mediatek.com> wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> MediaTek BTIF controller is the serial interface similar to UART but it
> works only as the digital device which is mainly used to communicate with
> the connectivity module called CONNSYS inside the SoC which could be mostly
> found on those MediaTek SoCs with Bluetooth feature such as MT7622 and
> MT7623 SoCs.
>
> And the controller is made as being compatible with the 8250 register
> layout with extra registers such as DMA enablement so it tends to be
> integrated with reusing 8250 OF driver. However, DMA mode is not being
> supported yet in the current driver.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
