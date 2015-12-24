From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Dec 2015 10:53:19 -0800
Subject: [PATCH 1/2] ARM: ATAGS: move save_atags() to include/asm
 arch/arm/include/asm/setup.h
In-Reply-To: <201512241848.17946@pali>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201512241848.17946@pali>
Message-ID: <20151224185319.GT2793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [151224 09:48]:
> On Thursday 24 December 2015 17:37:55 Ivaylo Dimitrov wrote:
> > So it can be used by code outside arch/arm/kernel/. Fix save_atags()
> > declaration to match its definition while at it.
> > 
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> 
> Tested-by: Pali Roh?r <pali.rohar@gmail.com>

Nice, please upload both to Russell's patch system after no
more comments:

Acked-by: Tony Lindgren <tony@atomide.com>
