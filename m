From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 05 Jan 2017 13:39:38 +0100
Subject: [PATCH v5 1/4] clk: rockchip: add dt-binding header for rk3328
In-Reply-To: <1482979511-6847-2-git-send-email-zhangqing@rock-chips.com>
References: <1482979511-6847-1-git-send-email-zhangqing@rock-chips.com>
 <1482979511-6847-2-git-send-email-zhangqing@rock-chips.com>
Message-ID: <6625105.hZYF0iglUL@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 29. Dezember 2016, 10:45:08 CET schrieb Elaine Zhang:
> Add the dt-bindings header for the rk3328, that gets shared between
> the clock controller and the clock references in the dts.
> Add softreset ID for rk3328.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied, after moving the clock-ids a bit more together [0],
as limiting the number of empty entries in the clk-id array saves us a bit of
space. But please double check and shout if something looks wrong :-)


Thanks
Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=6cc1aef0ad0daea0c6ba5432a8a6fe1c30661e4c
