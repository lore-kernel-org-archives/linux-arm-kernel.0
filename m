From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 27 Mar 2016 23:26:52 +0200
Subject: [PATCH v5 1/4] clk: rockchip: fix big.LITTLE cores alternate
 reparent failed
In-Reply-To: <1458974276-10325-2-git-send-email-zhengxing@rock-chips.com>
References: <1458974276-10325-1-git-send-email-zhengxing@rock-chips.com>
 <1458974276-10325-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1608479.lxyeMomFsd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 26. M?rz 2016, 14:37:53 schrieb Xing Zheng:
> On the RK3399, the order of the core's parents are LPLL/BPLL/DPLL/GPLL,
> there is incorrect to select bit_0 and bit_1 as the main and alternate
> parents for LPLL/BPLL. They should be configurable.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

I've folded this fix into the original patch [0]


Thanks
Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.7-clk/next&id=268aebaa2410152bf91ea1ede6b284ff8138822d
