From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 27 Nov 2017 14:47:54 +0800
Subject: [PATCH] pinctrl: sunxi: Fix A64 UART mux value
In-Reply-To: <20171125121230.23555-1-andre.przywara@arm.com>
References: <20171125121230.23555-1-andre.przywara@arm.com>
Message-ID: <CAGb2v65jB68TgGpnfZFy8K07qcM=WT5Qq9p8DQdS+eYAyc73Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 8:12 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> To use pin PF4 as the RX signal of UART0, we have to write 0b011 into
> the respective pin controller register.
> Fix the wrong value we had in our table so far.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Fixes: 96851d391d02 ("drivers: pinctrl: add driver for Allwinner A64 SoC")
Acked-by: Chen-Yu Tsai <wens@csie.org>
