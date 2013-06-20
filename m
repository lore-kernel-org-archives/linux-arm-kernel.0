From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 20 Jun 2013 19:04:38 +0200
Subject: [PATCH/RESEND 06/12] msm: iommu: Use clk_set_rate() instead of
 clk_set_min_rate()
In-Reply-To: <20130620164142.GD6300@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
 <1371490999-15501-7-git-send-email-sboyd@codeaurora.org>
 <20130620164142.GD6300@codeaurora.org>
Message-ID: <20130620170437.GB11309@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 09:41:42AM -0700, Stephen Boyd wrote:
> Sending to correct Joerg address.
> 
> On 06/17, Stephen Boyd wrote:
> > Calling clk_set_min_rate() is no better than just calling
> > clk_set_rate() because MSM clock code already takes care of
> > calling the min_rate ops if the clock really needs
> > clk_set_min_rate() called on it.
> > 
> > Cc: Joerg Roedel <joerg.roedel@amd.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Joerg Roedel <joro@8bytes.org>
