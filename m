From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 6 Aug 2016 10:59:53 -0300
Subject: [PATCH v2 2/2] imx53.dtsi : Add DMA configuration for UART
In-Reply-To: <1470307750.712399023@f361.i.mail.ru>
References: <CAOMZO5BoRsrHv-+5c9bAXO2NCya8sPqmmpy9DOfav6NvQ+VMLQ@mail.gmail.com>
 <1470306157-11181-1-git-send-email-fabien.lahoudere@collabora.co.uk>
 <1470306157-11181-2-git-send-email-fabien.lahoudere@collabora.co.uk>
 <1470307750.712399023@f361.i.mail.ru>
Message-ID: <CAOMZO5DAAU0jUpd2xwgTwL9Y1Bhido35fxvhQ9HGZRXbRnB2Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 4, 2016 at 7:49 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> Hello.
>
> UART SDMA has been tested by me for i.MX51.
> So, on my opinion, In the first part of the patch, we just need to remove is_imx6q_uart()
> check on and always let the devicetree decide about DMA usage.

Yes, agreed.
