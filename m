From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Sep 2015 23:55:43 +0200
Subject: [PATCH v2 1/3] ARM: dts: support Highspeed for rk3188-radxarock
In-Reply-To: <1442052050-20110-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442052050-20110-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <2555868.TIXXOkXmoo@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Samstag, 12. September 2015, 18:00:50 schrieb Shawn Lin:
> Add cap-sd-highspeed and cap-mmc-highspeed for rk3188-radxarock
> board to make sd cards running faster.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

I've applied your patches to my dts-branch [0]. I did merge the two rk3066 
board changes into one patch, so there is now one for rk3188 and one for 3066.


[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v4.4-armsoc/dts32
