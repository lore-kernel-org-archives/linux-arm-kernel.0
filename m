From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 22 Mar 2013 14:15:07 +0200
Subject: [PATCH REPOST v2] clk: add table lookup to mux
In-Reply-To: <1363954078-29952-1-git-send-email-pdeschrijver@nvidia.com>
References: <1363954078-29952-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130322121507.GX18519@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 01:07:53PM +0100, Peter De Schrijver wrote:
> Add a table lookup feature to the mux clock. Also allow arbitrary masks
> instead of the width. This will be used by some clocks on Tegra114. Also
> adapt the tegra periph clk because it uses struct clk_mux directly.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

This is actually the first post, despite the subject.

Thanks,

Peter.
