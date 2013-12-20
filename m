From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 12:17:27 +0100
Subject: [PATCH 04/10] ARM: tegra: Add Tegra124 eDP support
In-Reply-To: <52B35B15.4090008@wwwdotorg.org>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-5-git-send-email-treding@nvidia.com>
 <52B35B15.4090008@wwwdotorg.org>
Message-ID: <20131220111726.GM27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 01:46:13PM -0700, Stephen Warren wrote:
> On 12/19/2013 09:06 AM, Thierry Reding wrote:
> 
> > diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> 
> > +		sor at 54540000 {
> > +			compatible = "nvidia,tegra124-sor";
> 
> I don't see a binding document for that compatible value anywhere in
> next-20131219, nor in your drm/for-next branch. Still, the DT
> content/schema is essentially identical to many others that already
> exist, so I won't block applying the series because of that. Please do
> write a binding document though!
> 
> > +		dpaux at 545c0000 {
> > +			compatible = "nvidia,tegra124-dpaux";
> 
> Same comment.

The binding documentation for those nodes is part of the eDP patch
that's still awaiting internal review, that's why it hasn't appeared yet
in linux-next or my drm/for-next branch. I'm hoping that will happen any
day now, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/78ec0c0d/attachment.sig>
