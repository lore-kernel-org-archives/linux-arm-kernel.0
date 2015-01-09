From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 9 Jan 2015 11:12:53 +0100
Subject: [PATCH] soc/tegra: pmc: Add Tegra132 support
In-Reply-To: <alpine.DEB.2.02.1501082232280.28771@utopia.booyaka.com>
References: <1420701657-32543-1-git-send-email-thierry.reding@gmail.com>
 <alpine.DEB.2.02.1501082232280.28771@utopia.booyaka.com>
Message-ID: <20150109101252.GG27845@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 10:34:35PM +0000, Paul Walmsley wrote:
> On Thu, 8 Jan 2015, Thierry Reding wrote:
> 
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Tegra132 uses the same GPU as Tegra124 and the same special-case is
> > needed to remove clamps. However Tegra132 has a separate chip ID, so in
> > order to avoid having to extend the list of chip IDs for the special
> > case, add a feature flag to the SoC data.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Reviewed-by: Paul Walmsley <pwalmsley@nvidia.com>
> 
> Nit: not sure I would call it a special-case; to me it's more of an 
> evolutionary change due to the radically different GPU in T124 & T132.

I reworded the commit message slightly, so it says:

	Tegra132 uses the same GPU as Tegra124 and therefore requires the same
	method to remove clamps. ...

I hope that's less misleading.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/493b4c66/attachment.sig>
