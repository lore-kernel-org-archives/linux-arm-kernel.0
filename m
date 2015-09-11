From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 11 Sep 2015 11:54:41 +0100
Subject: [PATCH v4 3/4] irqchip: GIC: Convert to EOImode == 1
In-Reply-To: <55F1AE75.6000405@citrix.com>
References: <1440604845-28229-1-git-send-email-marc.zyngier@arm.com>
 <1440604845-28229-4-git-send-email-marc.zyngier@arm.com>
 <55F08731.3050402@citrix.com> <55F15353.2000800@arm.com>
 <55F1AE75.6000405@citrix.com>
Message-ID: <1441968881.3549.20.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-09-10 at 17:23 +0100, Julien Grall wrote:
> I applied the two patches on top of linus/master and I'm able to boot
> correctly on X-gene. Thank you!

Perhaps we should replicate this approach in Xen and get rid of
 PLATFORM_QUIRK_GIC_64K_STRIDE?

Ian.
