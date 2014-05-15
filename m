From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 13:39:21 +0200
Subject: [PATCHv3 2/3] ARM: mm: add support for HW coherent systems in
 PL310
In-Reply-To: <20140515093639.GF11117@localhost>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400145519-28530-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140515093639.GF11117@localhost>
Message-ID: <20140515133921.5b153362@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin Marinas,

On Thu, 15 May 2014 10:36:39 +0100, Catalin Marinas wrote:

> > While in theory any write to a PL310 register could cause the
> > deadlock, in practice, disabling ->sync is sufficient to workaround
> > the deadlock, since the other cache maintenance operations are only
> > used in very specific situations.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks a lot for having reviewed these patches! I will submit PATCH 1/3
and PATCH 2/3 in Russell's patch system now.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
