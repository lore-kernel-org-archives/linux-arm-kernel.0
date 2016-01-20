From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 20 Jan 2016 02:08:36 +0100
Subject: [PATCH 1/2] ARM: dts: kirkwood: split lswxl into linkstation
 lswsxl and lswxl
In-Reply-To: <1453211342-25214-2-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453211342-25214-2-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160120010836.GA22177@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	gpio_leds {
> +		red-alarm-led {
> +			label = "red:alarm";

Led labels are supposed to have the machine name in them. This used to
be "lswxl:red:alarm". It cannot be so specific now that it is in a
dtsi file. So i would suggest "linkstation:red:alarm".

Otherwise, these changes look O.K.

	   Andrew
