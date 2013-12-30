From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Dec 2013 16:11:55 +0100
Subject: [PATCH v2 3/4] pinctrl: sunxi: Add Allwinner A20 clock output
 pin functions
In-Reply-To: <1388373949-28506-4-git-send-email-wens@csie.org>
References: <1388373949-28506-1-git-send-email-wens@csie.org>
 <1388373949-28506-4-git-send-email-wens@csie.org>
Message-ID: <20131230151155.GR3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, Dec 30, 2013 at 11:25:48AM +0800, Chen-Yu Tsai wrote:
> This patch adds the clock output pin functions on the A20.
> The 2 pins can output a configurable clock to be used by
> external modules. This is used on the CubieTruck, to supply
> a 32768 Hz low power clock to the onboard Wifi+BT module.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/59c41610/attachment-0001.sig>
