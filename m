From: treding@nvidia.com (Thierry Reding)
Date: Fri, 6 Dec 2013 10:58:19 +0100
Subject: [PATCH 4/4] pinctrl: tegra: add pinmux controller driver for
 Tegra124
In-Reply-To: <52A10C7B.8070406@wwwdotorg.org>
References: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
 <1386241070-4350-5-git-send-email-ldewangan@nvidia.com>
 <52A10C7B.8070406@wwwdotorg.org>
Message-ID: <20131206095819.GB29035@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 12:30:03AM +0100, Stephen Warren wrote:
> On 12/05/2013 03:57 AM, Laxman Dewangan wrote:
> > From: Ashwini Ghuge <aghuge@nvidia.com>
> > 
> > This adds a driver for the Tegra124 pinmux, and required
> > parameterization data for Tegra124.
> > 
> > The driver uses the common Tegra pincontrol driver utility
> > functions to implement the majority of the driver.
> > 
> > This driver is not compatible with the earlier NVIDIA's SoCs,
> > hence add new compatibile as "nvidia,tegra124-pinmux".
> > 
> > Originally written by Ashwini Gguhe.
> > ldewangan:
> >         - cleanup the patches,
> >         - Fix address issue.
> 
> IIRC, Thierry mentioned he had some fixes in his local branch for this
> driver. Thierry, can you please confirm/deny this?

I'll try to get this version tested today and report back if any changes
are still required.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/6fec3a21/attachment.sig>
