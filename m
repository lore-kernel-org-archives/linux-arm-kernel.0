From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 04 Sep 2010 06:36:40 +0900
Subject: [PATCH] ARM: SAMSUNG: Removed redunt zreladdr in Makefile.boot
In-Reply-To: <20100903074247.GG26319@n2100.arm.linux.org.uk>
References: <1283470043-16050-1-git-send-email-kgene.kim@samsung.com>
	<20100903074247.GG26319@n2100.arm.linux.org.uk>
Message-ID: <01dd01cb4bb0$1c124dc0$5436e940$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
Hi ;-)

> On Fri, Sep 03, 2010 at 08:27:23AM +0900, Kukjin Kim wrote:
> > Because can be calculated ZREADDR now, removed redunt zreladdr
> > definitions in each Makefile.boot of Samsung architectures.
> 
> I'd suggest holding off on this.  CONFIG_ZRELADDR has a few problems
> at the moment that need fixing - and if there's no movement to fix
> them, it'll be reverted.

Ok...And I will check its progress in the mailing list.

Have a nice weekend.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
