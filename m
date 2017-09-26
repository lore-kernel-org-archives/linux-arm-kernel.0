From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 15:01:08 +0200
Subject: [PATCH v2 03/10] pinctrl: axp209: use drv_data of
 pinctrl_pin_desc to store pin reg
In-Reply-To: <7993a30fbc2e50a2d228fa0c8fad643c4034b101.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <7993a30fbc2e50a2d228fa0c8fad643c4034b101.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170926130108.uibnri32b73elfy6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 12:17:13PM +0000, Quentin Schulz wrote:
> Instead of using a function to retrieve each pin's correct control
> register, use drv_data within pinctrl_pin_desc to store the ctrl reg.
> 
> Remove axp20x_gpio_get_reg and replace every occurrence by a get from
> drv_data.

Why do you need to do that? This should be explained.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/560bafdb/attachment.sig>
