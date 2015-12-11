From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 11 Dec 2015 15:39:55 +0100
Subject: [PATCH 2/2 v2] ARM: mvebu: kirkwood: add PogoPlug series 4
 device tree
In-Reply-To: <1449824224-29765-1-git-send-email-linus.walleij@linaro.org>
References: <1449824224-29765-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151211143955.GG12282@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

> +&uart0 {
> +	status = "okay";
> +	current-speed = <115200>;
> +};

You should not need this. There are no other DTS files with it. As far
as i understand, the bootloader may add this to the DT blob before
passing it to the kernel, but i doubt the stock bootloader on your
device is doing it.

Otherwise this looks good.

	  Andrew
