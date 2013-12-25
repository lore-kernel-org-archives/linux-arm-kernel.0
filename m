From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Dec 2013 21:05:32 -0500
Subject: [PATCH v3 1/2] ARM: Kirkwood: Add 6192 DTSI file
In-Reply-To: <1387889599-12898-1-git-send-email-maxime.hadjinlian@gmail.com>
References: <1387889599-12898-1-git-send-email-maxime.hadjinlian@gmail.com>
Message-ID: <20131225020532.GJ19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 01:53:18PM +0100, Maxime Hadjinlian wrote:
> This file is mainly a copy of kirkwood-6281.dtsi.
> The pinctrl seems to be the same.
> These platforms differs only with their CPU, memory capabilities and the
> number of GPIO available (36 on 6192, 50 on 6281).
> 
> Signed-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
> ---
>  arch/arm/boot/dts/kirkwood-6192.dtsi | 107 +++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-6192.dtsi

Whole series applied to mvebu/dt with Andrew's Ack.

Ho, Ho, Ho!

Jason.
