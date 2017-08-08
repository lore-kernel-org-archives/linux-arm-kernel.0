From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 08 Aug 2017 17:58:22 +0200
Subject: [PATCH 1/2] clk: fractional-divider: allow overriding of
 approximation
In-Reply-To: <5453089.AIzWDZk3ey@phil>
References: <1500624187-12165-1-git-send-email-zhangqing@rock-chips.com>
 <5990882.df1suBpf8V@phil> <5453089.AIzWDZk3ey@phil>
Message-ID: <1694589.HBVVhCKeO5@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 1. August 2017, 18:21:22 CEST schrieb Heiko Stuebner:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Fractional dividers may have special requirements concerning numerator
> and denominator selection that differ from just getting the best
> approximation.
> 
> For example on Rockchip socs the denominator must be at least 20 times
> larger than the numerator to generate precise clock frequencies.
> 
> Therefore add the ability to provide custom approximation functions.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied for 4.14 with Stephen's Ack


Heiko
