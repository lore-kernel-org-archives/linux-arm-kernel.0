From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 7 Sep 2016 20:31:07 -0700
Subject: [PATCH V2] ARM: BCM5301X: Add basic dts for BCM53573 based Tenda
 AC9
In-Reply-To: <20160823053746.14521-1-zajec5@gmail.com>
References: <1469654305-1700-1-git-send-email-zajec5@gmail.com>
 <20160823053746.14521-1-zajec5@gmail.com>
Message-ID: <a10d2d61-158f-2f03-fe77-9cbb0603e715@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/08/2016 ? 22:37, Rafa? Mi?ecki a ?crit :
> BCM53573 seems to be low priced alternative for Northstar chipsts. It
> uses single core Cortex-A7 and doesn't have SDU or local (TWD) timer. It
> was also stripped out of independent SPI controller and 2 GMACs.
> 
> DTS for Tenda AC9 isn't completed yet. It misses e.g. switch entry (we
> still need some b53 fixes) and probably some clocks. It adds support for
> basic features however and can be improved later.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Applied, thanks!
-- 
Florian
