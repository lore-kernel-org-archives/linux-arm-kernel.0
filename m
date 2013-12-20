From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 12:56:13 +0100
Subject: [PATCH 03/10] ARM: tegra: Add MIPI calibration DT entries for
 Tegra114
In-Reply-To: <52B38B14.8080605@wwwdotorg.org>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
 <1387468774-14216-4-git-send-email-treding@nvidia.com>
 <52B38B14.8080605@wwwdotorg.org>
Message-ID: <20131220115613.GP27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 05:11:00PM -0700, Stephen Warren wrote:
> On 12/19/2013 08:59 AM, Thierry Reding wrote:
> > Add a device node for the MIPI calibration block on Tegra114. There is
> > no need to disable it by default because it only enables the clock while
> > performing calibration and therefore shouldn't be consuming any power
> > when unused.
> 
> > diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> 
> > +	mipi: mipi {
> 
> That should be:
> 
> 	mipi: mipi at 700e3000 {
> 
> I fixed it up for you.

Right. Many of the patches I'm carrying locally predate the unit number
requirement change. I did make a pass to update all, but this must have
slipped through the cracks.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/16b0d536/attachment.sig>
