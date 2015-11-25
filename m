From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Nov 2015 16:01:02 -0800
Subject: [PATCH v2 3/3] ARM: BCM5301X: remove workaround imprecise abort
 fault handler
In-Reply-To: <1444905142-21500-4-git-send-email-l.stach@pengutronix.de>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
 <1444905142-21500-4-git-send-email-l.stach@pengutronix.de>
Message-ID: <5654FA3E.6020609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 03:32, Lucas Stach wrote:
> This is not needed anymore. Handling a potentially pending imprecise external
> abort left behind by the bootloader is now done in a slightly safer way inside
> the common ARM startup code.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to soc/next, thanks!
-- 
Florian
