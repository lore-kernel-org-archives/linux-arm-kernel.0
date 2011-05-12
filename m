From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2011 03:16:31 -0700
Subject: [PATCH v2] arm: omap2plus: GPIO cleanup
In-Reply-To: <4DCA3D02.9070608@compulab.co.il>
References: <20110503103952.GP2092@atomide.com>
	<1304436129-7165-1-git-send-email-grinberg@compulab.co.il>
	<4DCA3D02.9070608@compulab.co.il>
Message-ID: <20110512101630.GI31483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110511 00:35]:
> ping!
> 
> On 05/03/11 18:22, Igor Grinberg wrote:
> 
> > use gpio_request_<one|array>() instead of multiple gpiolib calls,
> > remove unneeded variables, etc.

Thanks that shrinks down the board files nicely. Applying to
devel-cleanup.

Regards,

Tony
