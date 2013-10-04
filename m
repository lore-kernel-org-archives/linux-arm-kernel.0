From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 4 Oct 2013 18:52:36 +0300
Subject: [PATCH] clk: tegra: replace enum tegra114_clk by binding header
In-Reply-To: <522622F1.70008@wwwdotorg.org>
References: <1378213915-10222-1-git-send-email-pdeschrijver@nvidia.com>
 <522622F1.70008@wwwdotorg.org>
Message-ID: <20131004155236.GX3973@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 07:57:05PM +0200, Stephen Warren wrote:
> On 09/03/2013 07:11 AM, Peter De Schrijver wrote:
> > As the clock IDs are now specified in a header file, we can use those
> > definitions instead of maintaining an internal enum.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> I assume this will go through Mike's clock tree for 3.13.
> 

Mike?

> I assume similar patches will follow for Tegra20/30?

Yes.
