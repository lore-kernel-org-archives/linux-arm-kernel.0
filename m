From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 20 Jun 2013 19:04:01 +0200
Subject: [PATCH/RESEND 05/12] msm: iommu: Convert to clk_prepare/unprepare
In-Reply-To: <20130620164051.GC6300@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
 <1371490999-15501-6-git-send-email-sboyd@codeaurora.org>
 <20130620164051.GC6300@codeaurora.org>
Message-ID: <20130620170401.GA11309@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 09:40:51AM -0700, Stephen Boyd wrote:
> Sending to correct Joerg address.
> 
> On 06/17, Stephen Boyd wrote:
> > Add calls to clk_prepare and unprepare so that MSM can migrate to
> > the common clock framework. We never unprepare the clocks until
> > driver remove because the clocks are enabled and disabled in irq
> > context. Finer grained power management is possible in the future
> > via runtime power management techniques.
> > 
> > Cc: Joerg Roedel <joerg.roedel@amd.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Joerg Roedel <joro@8bytes.org>
