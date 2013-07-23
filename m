From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Jul 2013 11:01:24 +0100
Subject: [PATCH 0/3] arm/arm64: a trio of boot mode detection fixes
In-Reply-To: <20130718162501.GA20870@e106331-lin.cambridge.arm.com>
References: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
 <51E8091A.5040302@arm.com>
 <20130718162501.GA20870@e106331-lin.cambridge.arm.com>
Message-ID: <20130723100122.GA3748@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 05:25:01PM +0100, Mark Rutland wrote:
> On Thu, Jul 18, 2013 at 04:26:18PM +0100, Marc Zyngier wrote:
> > On 09/07/13 15:16, Mark Rutland wrote:
> > > The following patches fix a couple of issues in the boot mode detection
> > > code where in the case of mismatched boot modes we can corrupt a small
> > > portion of memory or fail to detect the fact we've booted CPUs with
> > > mismatched modes due to the boot mode being logged incoherently.
> > 
> > Sorry for the delay in replying to this. The whole series looks good to
> > me, so: Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Cheers.
> 
> Russell,
> I've dropped the first two patches into the patch system as 7786/1 and
> 7787/1.
> 
> Catalin,
> Are you happy to pick up the third patch?

Yes. Thanks.

-- 
Catalin
