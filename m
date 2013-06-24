From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Jun 2013 20:52:58 -0300
Subject: [patch 1/1] imx53-qsb: enable usb power
In-Reply-To: <20130620212939.018670789@rtp-net.org>
References: <20130620212939.018670789@rtp-net.org>
Message-ID: <CAOMZO5Bk6hBtK1G_jGejAg2+2L+cJqTw-NebKUpVn-6XwBUWxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 6:29 PM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> Enable usb power pin by using a fixed regulator. With this and the usb clock
> patch is making usb working on my loco.
>
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Could you please test this against linux-next?

It does not work for me:

usbcore: registered new interface driver usb-storage
platform 53f80000.usb: Driver imx_usb requests probe deferral
platform 53f80200.usb: Driver imx_usb requests probe deferral
