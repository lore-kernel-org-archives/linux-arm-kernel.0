From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Jan 2017 09:59:32 +0000
Subject: [PATCH v3 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170111183738.GD29247@leverpostej>
References: <20170111144118.17062-1-cov@codeaurora.org>
 <20170111144118.17062-2-cov@codeaurora.org>
 <20170111180627.GG20288@e104818-lin.cambridge.arm.com>
 <20170111183339.GC29247@leverpostej>
 <5da456f8-fcc5-b6e2-d58b-01a671da595b@codeaurora.org>
 <20170111183738.GD29247@leverpostej>
Message-ID: <20170112095932.q54jyb33gxyp2ccu@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 06:37:39PM +0000, Mark Rutland wrote:
> On Wed, Jan 11, 2017 at 12:35:55PM -0600, Timur Tabi wrote:
> > On 01/11/2017 12:33 PM, Mark Rutland wrote:
> > >It'll need to affect all lines since the kconfig column needs to expand
> > >by at least one character to fit QCOM_FALKOR_ERRATUM_1003.
> > 
> > Or we can make the macro shorter.
> 
> The name, as it is, is perfectly descriptive.
> 
> Let's not sacrifice legibility over a non-issue.

I agree, I didn't realise that the we expand the last column already.
It's a non-issue indeed.

-- 
Catalin
