From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 21 Dec 2015 22:21:33 +0800
Subject: [linux-sunxi][PATCH v2 3/5] ARM: dts: sun7i: Add Itead Ibox
 support
In-Reply-To: <1450537521-6476-4-git-send-email-codekipper@gmail.com>
References: <1450537521-6476-1-git-send-email-codekipper@gmail.com>
 <1450537521-6476-4-git-send-email-codekipper@gmail.com>
Message-ID: <CAGb2v64qmYbn+v+CY3qW54A9B9gY7F-PszYv_fNeAGJ1CY7HQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 11:05 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The Itead Ibox is a multi board device based on the Allwinner A20 SoC.
> It contains the A20 Itead Core module and a base board for the external
> interfaces.
>
> The core module comes with 4GB NAND and 1GB DDR RAM.
>
> The base board to which the core board is connected provides 3 USB 2.0 Host
> ports, 1 USB 2.0 OTG, 1 uSD slot, 10/100 Ethernet port, HDMI, IR receiver,
> SPDIF and a 32-pin GPIO header. This header expands the features of core
> board by exposing the VGA pins, audio In/Out pins, SATA, SPI, I2C, UARTS,
> USB-OTG and power.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
