From: joro@8bytes.org (joro at 8bytes.org)
Date: Fri, 27 Apr 2018 13:46:19 +0200
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <20180427113923.GF17484@dhcp22.suse.cz>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org>
 <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
 <20180427113923.GF17484@dhcp22.suse.cz>
Message-ID: <20180427114619.GV15462@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 01:39:23PM +0200, Michal Hocko wrote:
> On Fri 27-04-18 09:37:20, joro at 8bytes.org wrote:
> [...]
> > So until we make the generic ioremap code in lib/ioremap.c smarter about
> > unmapping/remapping ranges the best solution is making my fix work again
> > by reverting your patch.
> 
> Could you reuse the same mmu_gather mechanism as we use in the
> zap_*_range?

Yeah, maybe, I havn't looked into the details yet. At least something
similar is needed.


	Joerg
