From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 28 Jan 2016 18:01:08 +0100
Subject: [PATCH] clk: rockchip: Allow sclk_i2s0 and i2s0_frac to change
 their parents rate on rk3188
In-Reply-To: <1453897469-2134-1-git-send-email-al.kochet@gmail.com>
References: <1453897469-2134-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1687954.9WCMHmWDJQ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Am Mittwoch, 27. Januar 2016, 15:24:29 schrieb Alexander Kochetkov:
> Allow sclk_i2s0 and i2s0_frac to change their parents rate as
> that the upstream dividers are purely there to feed sclk_i2s0
> 
> Tested on radxarock-lite.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

doesn't apply due to the fractional divider change going into 4.5

please respin on top of 4.5-rc1 (or my clock-branch for 4.6 [0],
but should be the same in that regard).


Thanks
Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v4.6-clk/next
