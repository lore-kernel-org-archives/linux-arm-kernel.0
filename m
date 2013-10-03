From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 3 Oct 2013 18:35:19 +0300
Subject: [PATCH] clk: tegra: PLLE spread spectrum control
In-Reply-To: <524D8C0B.90707@wwwdotorg.org>
References: <1380209654-25458-1-git-send-email-pdeschrijver@nvidia.com>
 <524B28EA.40702@wwwdotorg.org>
 <20131003105228.GK3973@tbergstrom-lnx.Nvidia.com>
 <524D8C0B.90707@wwwdotorg.org>
Message-ID: <20131003153519.GT3973@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 05:23:55PM +0200, Stephen Warren wrote:
> On 10/03/2013 04:52 AM, Peter De Schrijver wrote:
> > On Tue, Oct 01, 2013 at 09:56:26PM +0200, Stephen Warren wrote:
> >> On 09/26/2013 09:34 AM, Peter De Schrijver wrote:
> >>> Add spread spectrum control for PLLE in Tegra114.
> >>
> >> It would be useful to have some description of the end-user-visible
> >> benefit of this change; why is it useful?
> > 
> > spread spectrum clocking is a technique to reduce EMI caused by the clock
> > signal by modulating the frequency with a low frequency signal. This should
> > reduce interference with eg. Wifi or cellular modems on the same board.
> 
> Great. The intent of my request was for that information to be included
> in the patch description.
> 

Mike,

Do you want a version 2 for this?

Cheers,

Peter.
