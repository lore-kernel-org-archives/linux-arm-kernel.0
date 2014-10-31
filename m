From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Oct 2014 09:27:25 +0100
Subject: [PATCH v2 0/6] ARM: sun9i: Enable extra uarts, leds and i2c
 controllers
In-Reply-To: <1414724751-25580-1-git-send-email-wens@csie.org>
References: <1414724751-25580-1-git-send-email-wens@csie.org>
Message-ID: <20141031082725.GU21251@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 11:05:45AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This series enables the uart and i2c controller found on the A80 Optimus
> board's gpio expansion header, as well as 2 out of 3 onboard LEDs. The
> last LED needs R_PIO support.
> 
> This series contains only changes to the dtsi and dts files, and is based
> on Maxime's pinctrl driver series. The patches should be self-explanatory.
> 
> Changes since v1:
> 
>   - Dropped a80_ prefix on the led labels
>   - Fixed mapping for leds to pins, previously led2 and led4 were reversed.
>   - Use dash instead of underscore in led-pins DT node name


Merged, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/f3709f90/attachment.sig>
