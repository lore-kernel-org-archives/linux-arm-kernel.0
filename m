From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Dec 2011 16:31:42 -0800
Subject: [PATCH] ARM: OMAP3: hsmmc: fix MMC 2 setup for AM35x
In-Reply-To: <4EE10F20.5080806@compulab.co.il>
References: <1322559468-5883-1-git-send-email-grinberg@compulab.co.il>
 <4EE10F20.5080806@compulab.co.il>
Message-ID: <20111209003142.GG31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [111208 10:53]:
> ping
> 
> Tony,
> I'd like this to go into 3.3, can it?
> 
> On 11/29/11 11:37, Igor Grinberg wrote:
> > AM35x MMC 2 controller has internal clock loopback setting which cannot
> > be utilized without this patch and thus SDIO devices connected to this
> > controller and depend on this setting will fail to initialize.

Yes seems OK for now so applying into omap driver branch.

Regards,

Tony
