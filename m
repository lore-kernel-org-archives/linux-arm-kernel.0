From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Jun 2016 19:21:47 +0100
Subject: [PATCH 0/3] arm64: Kill ESR_LNX_EXEC
In-Reply-To: <20160531165311.GD11321@e104818-lin.cambridge.arm.com>
References: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
 <20160531165311.GD11321@e104818-lin.cambridge.arm.com>
Message-ID: <20160602182146.GG7697@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 05:53:11PM +0100, Catalin Marinas wrote:
> On Tue, May 31, 2016 at 12:33:00PM +0100, Mark Rutland wrote:
> > Mark Rutland (3):
> >   arm64: add macro to extract ESR_ELx.EC
> >   arm64/kvm: use ESR_ELx_EC to extract EC
> >   arm64: kill ESR_LNX_EXEC
> 
> For the series:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

You may as well queue this for 4.8 when you start picking up patches.
I don't think it warrants going in for 4.7, since it doesn't actually
fix anything.

Will
