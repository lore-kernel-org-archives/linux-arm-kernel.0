From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Oct 2015 11:18:32 +0000
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <1446159360613.1984@nvidia.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
 <CAKv+Gu-CgXU4O8SymcjmCYZqyAa0PZbJXwNqXfuCamxYY9C8GA@mail.gmail.com>
 <1446159360613.1984@nvidia.com>
Message-ID: <20151030111832.GB20030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 10:54:31PM +0000, Alexander Van Brunt wrote:
> >I think we have similar code in the ARM tree, so we should probably
> >make some changes there as well.
> 
> I don't have a working ARMv7 system anymore. So, I'll have to leave that to
> someone else.

Can you run KVM on your AArch64 machine? An AArch32 guest should be
sufficient for your needs.

Will
