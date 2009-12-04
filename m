From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 04 Dec 2009 09:55:48 +0000
Subject: [GIT PULL] Patches for 2.6.33
In-Reply-To: <1258369405.6705.28.camel@pc1117.cambridge.arm.com>
References: <1258367694.6705.16.camel@pc1117.cambridge.arm.com>
	<20091116105325.GA27894@n2100.arm.linux.org.uk>
	<1258369405.6705.28.camel@pc1117.cambridge.arm.com>
Message-ID: <1259920548.12495.6.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, 2009-11-16 at 11:03 +0000, Catalin Marinas wrote:
> Anyway, the for-rmk branch now looks like this:
> 
> The following changes since commit c97c5aa83c41a532bc67da356d77da929bc41b9c:
>   Catalin Marinas (1):
>         RealView: Add sparsemem support for the RealView PBX platform
> 
> are available in the git repository at:
> 
>   git://linux-arm.org/linux-2.6.git for-rmk
> 
> Catalin Marinas (1):
>       Add an earlyprintk debug console
> 
> Varun Swara (1):
>       Do not allow the probing of the local timer

Did you managed to pull these two patches? It looks like the other
patches in my for-rmk branch (including the sparsemem support for PBX)
went in during the -rc series and they are now in 2.6.32 (thanks!).

Do you plan to push the other two that were left during this merging
window? I can rebase the for-rmk branch to 2.6.32 so that it only
contains these two patches.

Thanks.

-- 
Catalin
