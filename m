From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 17 Jun 2014 12:59:13 +0300
Subject: [PATCH 4/9] clk: tegra: Enable hardware control of SATA PLL
In-Reply-To: <539F665E.3060007@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-5-git-send-email-mperttunen@nvidia.com>
 <539F665E.3060007@wwwdotorg.org>
Message-ID: <20140617095913.GE3407@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 11:49:18PM +0200, Stephen Warren wrote:
> On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> > This makes the SATA PLL be controlled by hardware instead of software.
> > This is required for working SATA support.
> 
> Peter, could you please take patches 4 and 5 through the clock tree. As
> far as I can tell, there's no compile-time dependency in the clock
> patches, so they can go through a different tree to the rest of the
> series without issue. These 2 patches look fine to me, so consider them:
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Ok. Will do.

Cheers,

Peter.
