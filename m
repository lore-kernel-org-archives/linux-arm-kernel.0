From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 23 Jun 2011 15:39:02 +0900
Subject: [PATCH 6/7] ARM: EXYNOS4: Add save/restore for more ARM	registers
In-Reply-To: <20110622145452.GR23234@n2100.arm.linux.org.uk>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-7-git-send-email-kgene.kim@samsung.com>
	<20110622145452.GR23234@n2100.arm.linux.org.uk>
Message-ID: <015801cc3170$42695800$c73c0800$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Wed, Jun 22, 2011 at 05:46:44PM +0900, Kukjin Kim wrote:
> > From: Jaecheol Lee <jc.lee@samsung.com>
> >
> > This patch adds save/restore for Power Control Register and
> > Diagnostic Register.
> 
> NAK.  Please see my further suspend consolidation patches posted earlier.
> I've also recently (last few days) moved these further forward and this
> code no longer exists in this file (all it contains is the early
> resume stuff.)
> 
Oops :(
OK, will re-work based on latest rmk/for-next :)

> My guess is that these two registers are samsung specific, and so they
> should be saved and restored by higher level code (eg, a syscore_ops
> for exynos4 specific stuff.)

Let me think again.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
