From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 14 Oct 2015 23:48:51 +0200
Subject: [PATCH 4/4] ARM: BCM5301X: remove workaround imprecise abort
 fault handler
In-Reply-To: <1444834113-18122-5-git-send-email-l.stach@pengutronix.de>
References: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
 <1444834113-18122-5-git-send-email-l.stach@pengutronix.de>
Message-ID: <561ECDC3.3070502@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 04:48 PM, Lucas Stach wrote:
> This is not needed anymore. Handling a potentially pending imprecise external
> abort left behind by the bootloader is now done in a slightly safer way inside
> the common ARM startup code.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

I tested this on my board and this fixes the problem.

Hauke
