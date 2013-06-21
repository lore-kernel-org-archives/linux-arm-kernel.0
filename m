From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jun 2013 10:47:24 +0100
Subject: [PATCH v2 0/2] ARM: Remove any correlation between IPC and
 BogoMips value
In-Reply-To: <1371746612-23950-1-git-send-email-will.deacon@arm.com>
References: <1371746612-23950-1-git-send-email-will.deacon@arm.com>
Message-ID: <51C4212C.4030403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/13 17:43, Will Deacon wrote:
> Hi all,
> 
> This is version two of the patches I originally posted here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/166728.html
> 
> Comments received there largely confirmed that it's not possible to choose
> an `obviously bogus' value for BogoMIPs, so instead I've bitten the bullet
> and removed the line altogether.
> 
> In the meantime, I've only had one complaint this month about BogoMIPs
> being wrong, so perhaps the initial posting served some purpose without
> even being merged!

For the whole series, and cheering loudly:
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
