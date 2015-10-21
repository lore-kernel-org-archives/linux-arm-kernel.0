From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Oct 2015 10:18:33 +0100
Subject: [PATCHv4 02/24] arm64: Delay ELF HWCAP initialisation until all
 CPUs are up
In-Reply-To: <20151021084434.GD4801@e103592.cambridge.arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
 <1445261101-22344-3-git-send-email-suzuki.poulose@arm.com>
 <20151021084434.GD4801@e103592.cambridge.arm.com>
Message-ID: <20151021091833.GM11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 09:44:38AM +0100, Dave P Martin wrote:
> On Mon, Oct 19, 2015 at 02:24:39PM +0100, Suzuki K. Poulose wrote:
> > Delay the ELF HWCAP initialisation untill all the (enabled) CPUs are
> 
> nit: untill
> 
> No need to fix this unless you respin the series for some other
> reason.

I fixed some spelling errors when I applied the patches. This is one of
them (though I may have missed others). I haven't pushed the patches out
yet, so there is time for some more tweaking.

-- 
Catalin
