From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Jun 2013 11:12:34 +0100
Subject: [PATCH v4 0/2] ARM: PJ4B: fix for 3.10-rc
In-Reply-To: <1370599460-9947-1-git-send-email-gregory.clement@free-electrons.com>
References: <1370599460-9947-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130607101234.GF3132@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 11:04:18AM +0100, Gregory CLEMENT wrote:
> Hello,
> 
> This path set allows to fix one errata for PJ4B CPUs.
> 
> Without this the Armada 370 based board can't boot anymore since
> 3.10-rc1. So this one really need to be applied on 3.10-rc.
> 
> As they were pending question for the second one, I preferred to keep
> it apart awaiting the answers from the Marvell engineer.
> 
> Both of the patches of this series are needed to fix the issue. Indeed
> if the CPU is not recognized as a PJ4B then the fix is not applied.

Reviewed-by: Will Deacon <will.deacon@arm.com>

Does this need a CC stable as well? I know that my TLB patch tickled it, but
that's not to say it couldn't occur with particular configurations of older
kernels.

Will
