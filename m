From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 17:59:28 +0200
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <ee7dd180-b1be-d780-00dc-7a5199833810@kernel.org>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-2-p.zabel@pengutronix.de>
 <ee7dd180-b1be-d780-00dc-7a5199833810@kernel.org>
Message-ID: <1502467168.2310.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Fri, 2017-08-11 at 10:39 -0500, Dinh Nguyen wrote:
> Hi Phillip,
> 
> This patch is failing to apply on both v4.13-rc4 and linux-next:
> 
> error: patch failed: drivers/reset/reset-sunxi.c:108
> error: drivers/reset/reset-sunxi.c: patch does not apply
> Patch failed at 0001 reset: add reset-simple to unify socfpga, stm32,
> sunxi, and zx2967

Sorry, I should have mentioned this is based on?[1].

[1] https://patchwork.kernel.org/patch/9895433/

That patch should make it into linux-next the next time it is rebuilt.
Right now it only sits in the reset/next branch at

    https://git.pengutronix.de/git/pza/linux reset/next

regards
Philipp
