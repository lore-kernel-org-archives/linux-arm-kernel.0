From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Feb 2017 19:03:09 +0100
Subject: [PATCH] ARM: dts: sun5i-gr8: Rename pwm0_pins_a to pwm0_pins
In-Reply-To: <20170210034234.3612-1-wens@csie.org>
References: <20170210034234.3612-1-wens@csie.org>
Message-ID: <20170210180309.nio3xgy2uxa22jhv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 11:42:34AM +0800, Chen-Yu Tsai wrote:
> The GR8, like other sun5i SoCs, has only 1 pin option for PWM0 output.
> Other SoCs had named the pingroup "pwm0_pins" in their dtsi files, while
> GR8 named it "pwm0_pins_a". When we switched to the new common sun5i
> dtsi file, we forgot to rename the pingroup references in the GR8 board
> dts files.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Fixes: a2138ce584d5 ("ARM: sun5i: gr8: Use common sun5i DTSI")

Squashed it in the previous patch.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/da12668d/attachment.sig>
