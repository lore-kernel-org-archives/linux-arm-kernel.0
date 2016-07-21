From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Jul 2016 14:46:47 +0200
Subject: [PATCH 03/18] ARM: mvebu: enable E1000E in mvebu_v7_defconfig
In-Reply-To: <20160721124408.GO1041@n2100.armlinux.org.uk>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-4-git-send-email-jaz@semihalf.com>
 <20160721124408.GO1041@n2100.armlinux.org.uk>
Message-ID: <20160721144647.78fce4a8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 21 Jul 2016 13:44:09 +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 21, 2016 at 02:43:59PM +0200, Grzegorz Jaszczyk wrote:
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>  
> 
> Why?  It's not like this is an on-soc device, but most likely a PCIe card.
> Should we build-in all PCIe drivers?

I agree.

> I think it makes more sense to have this as a module rather than built-in.

I would prefer to not have it all in the defconfig. I'd hate to have
a defconfig that builds tons of random modules "just because".

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
