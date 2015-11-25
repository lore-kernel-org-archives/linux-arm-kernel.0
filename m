From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Nov 2015 16:02:41 -0800
Subject: [PATCH] ARM: BCM5310X: activate erratas needed for SoC
In-Reply-To: <1448116187-22466-1-git-send-email-hauke@hauke-m.de>
References: <1448116187-22466-1-git-send-email-hauke@hauke-m.de>
Message-ID: <5654FAA1.7010406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/15 06:29, Hauke Mehrtens wrote:
> The BCM4708 I have, which is probably the first generation which got
> to the consumer market, is using a ARM Cortex-A9 rev r3p0 and a
> L2C-310 rev r3p2 L2 cache controller. There are 3 workarounds for known
> erratas in the Linux kernel which could be activated and will be in
> this patch. There are currently no workarounds which have to be
> activated for the L2C-310 rev r3p2 in Linux.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to soc/next, thanks!
-- 
Florian
