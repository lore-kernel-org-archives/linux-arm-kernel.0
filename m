From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 22 Aug 2017 02:56:26 +0200
Subject: [PATCH v2 3/4] clk: rockchip: rv1108: rename macphy to mac
In-Reply-To: <1503303367-17915-4-git-send-email-zhangqing@rock-chips.com>
References: <1503303367-17915-1-git-send-email-zhangqing@rock-chips.com>
 <1503303367-17915-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <5151080.hknpSUNAHO@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 21. August 2017, 16:16:06 CEST schrieb Elaine Zhang:
> This MAC has no internal phy for rv1108.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied for 4.14 after adapting the subject and adding a sentence
to the commit message that this change is safe due to gmac not
being used yet.


Heiko
