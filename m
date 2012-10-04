From: mporter@ti.com (Matt Porter)
Date: Thu, 4 Oct 2012 16:39:43 -0400
Subject: [PATCH v3 3/6] ARM: davinci: da850: changed SRAM allocator to
 shared ram.
In-Reply-To: <506D79A3.4020506@ti.com>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
 <1349276133-26408-4-git-send-email-mporter@ti.com>
 <506D79A3.4020506@ti.com>
Message-ID: <20121004203943.GM11149@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 05:27:23PM +0530, Sekhar Nori wrote:
> Matt,
> 
> On 10/3/2012 8:25 PM, Matt Porter wrote:
> > From: Subhasish Ghosh <subhasish@mistralsolutions.com>
> > 
> > This patch modifies the sram allocator to allocate memory
> > from the DA8XX shared RAM.
> > 
> > Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> > [rebased onto consolidated SRAM patches]
> > Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> > [rebased to mainline as consolidated SRAM patches were dropped]
> > Signed-off-by: Matt Porter <mporter@ti.com>
> 
> Were you able to test PM with this change or you need my help?

I verified suspend/resume is working fine with this change on
AM180x EVM. Will note this all in v4.

-Matt
