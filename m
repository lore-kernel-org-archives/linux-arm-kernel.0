From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 24 Sep 2018 12:10:49 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <a3da76eb-7d17-40ba-a98d-c4a743240785@cesnet.cz>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <a3da76eb-7d17-40ba-a98d-c4a743240785@cesnet.cz>
Message-ID: <20180924121049.2bd40c34@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 24 Sep 2018 12:02:33 +0200, Jan Kundr?t wrote:

> is there a proper patch for this? I've just verified that 4.19-rc5 won't 
> boot for me either. Thomas' quick patch applies and makes the problem go 
> away.

I was waiting for a quick review from Russell on my proposal, but since
it didn't happen so far, I will send a proper patch series, hopefully
today.

Thanks for your reminder!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
