From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 07 Jul 2015 18:09:18 -0700
Subject: [PATCH V2] ARM: BCM5301X: Enable UART0 on tested devices
In-Reply-To: <1435555336-25118-1-git-send-email-zajec5@gmail.com>
References: <1435513590-32139-1-git-send-email-zajec5@gmail.com>
 <1435555336-25118-1-git-send-email-zajec5@gmail.com>
Message-ID: <559C783E.2050704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/15 22:22, Rafa? Mi?ecki wrote:
> There are two possible UARTs so we have (both of) them disabled by
> default. Override uart0 status on devices that were verified to use it.
> In case of Netgear R6250 also drop an old (and invalid) overwrite. It
> doesn't have uart1 connected.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to devicetree/next, thanks!
-- 
Florian
