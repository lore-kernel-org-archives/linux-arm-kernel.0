From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 25 Nov 2013 15:42:05 +0200
Subject: [PATCH] clk: tegra: add FUSE clock device
In-Reply-To: <528F8462.4010105@wwwdotorg.org>
References: <1385001490-18927-1-git-send-email-acourbot@nvidia.com>
 <20131122134140.GE26617@tbergstrom-lnx.Nvidia.com>
 <528F8462.4010105@wwwdotorg.org>
Message-ID: <20131125134205.GH26617@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 05:20:50PM +0100, Stephen Warren wrote:
> On 11/22/2013 06:41 AM, Peter De Schrijver wrote:
> > On Thu, Nov 21, 2013 at 03:38:10AM +0100, Alexandre Courbot wrote:
> >> This clock is needed to ensure the FUSE registers can be accessed
> >> without freezing the system.
> >>
> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > 
> > Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Aren't you taking this patch through the clock tree?

Will do.
