From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 12 Dec 2017 09:29:48 +0100
Subject: [PATCH 2/4] ARM: dts: sun8i: a83t: Add I2S controller device nodes
In-Reply-To: <20171212081148.9194-3-wens@csie.org>
References: <20171212081148.9194-1-wens@csie.org>
 <20171212081148.9194-3-wens@csie.org>
Message-ID: <20171212082948.xjlwksmkaqg22b3a@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 12, 2017 at 04:11:46PM +0800, Chen-Yu Tsai wrote:
> The A83T has 3 I2S controllers. The first is multiplexed with the TDM
> controller. The pins are generally connected to the codec side of the
> AXP81x PMIC/codec/RTC chip. The second is free for other uses. The
> third only supports output, and is connected internally to the HDMI
> controller for HDMI audio output.
> 
> This patch adds device nodes for the controllers, and a default pinmux
> setting for the second controller.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171212/9a112455/attachment.sig>
