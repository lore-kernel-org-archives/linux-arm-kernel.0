From: treding@nvidia.com (Thierry Reding)
Date: Tue, 8 Apr 2014 21:54:42 +0200
Subject: [RFC 2/5] ARM: tegra: Add new PCIe regulator properties
In-Reply-To: <53444B2D.8050209@wwwdotorg.org>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
 <1396622969-17837-3-git-send-email-treding@nvidia.com>
 <53444B2D.8050209@wwwdotorg.org>
Message-ID: <20140408195442.GB21978@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 09:17:01PM +0200, Stephen Warren wrote:
> On 04/04/2014 08:49 AM, Thierry Reding wrote:
> > These new properties more accurately reflect the real connections of the
> > boards and therefore make it easier to match them up with schematics.
> 
> > diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> 
> >  	pcie-controller at 00003000 {
> >  		status = "okay";
> > +
> > +		/* AVDD_PEXA and VDD_PEXA are grounded on Cardhu. */
> 
> Perhaps add the word "inputs" before "are"?

Done. Thanks,

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/854c7914/attachment.sig>
