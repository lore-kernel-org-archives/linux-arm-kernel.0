From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Jan 2018 13:45:23 +0100
Subject: [PATCH v1 2/4] ARM: PWM: add allwinner sun8i R40/V40/T3 pwm
 support.
In-Reply-To: <20180111113241.GA21953@arx-s1>
References: <20180111113241.GA21953@arx-s1>
Message-ID: <20180111124523.pnn4rbczruflzprz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 11, 2018 at 07:32:41PM +0800, hao_zhang wrote:
> This patch add allwinner sun8i R40/V40/T3 pwm support.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>

I don't really know the PWM framework, so I'll obviously leave that
part to Thierry, but the DT and probe parts look ok.

You have a number of issues with checkpatch though still, please run
./scripts/checkpatch.pl --strict, and once all the issues have been
fixed:
Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/75846209/attachment.sig>
