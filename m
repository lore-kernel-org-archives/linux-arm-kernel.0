From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:08:02 +0100
Subject: [PATCH v6] ARM: PJ4B: fix for 3.10-rc
In-Reply-To: <1371729974-17950-1-git-send-email-gregory.clement@free-electrons.com>
References: <1371729974-17950-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130620140802.GO2842@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 01:06:13PM +0100, Gregory CLEMENT wrote:
> Hello,
> 
> This path allows to fix one errata for PJ4B CPUs.
> 
> Without this the Armada 370 based board can't boot anymore since
> 3.10-rc1. So this one really need to be applied on 3.10-rc.
> 
> As the patch fixing PJ4B ID have been merged in Russell King's git
> tree. I only sent this one. I have tested a build with the
> vexpress_defconfig and it no more failed.
> 
> I have also removed the acked-by from Nicolas Pitre and the
> Reviewed-by from Will Deacon as even the change are small it is still
> a new version.
> 
> Nicolas, Will, would you agree to give your acked-by and reviewed-by
> on this new version?

Sure, it's not much different to the last one.

Will
