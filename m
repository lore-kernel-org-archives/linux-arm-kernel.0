From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 22 Jun 2012 08:06:57 +0200
Subject: [PATCH v2 08/10] ARM: tegra: harmony: Initialize regulators from
 DT
In-Reply-To: <4FE3815C.8030505@wwwdotorg.org>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
 <4FE3815C.8030505@wwwdotorg.org>
Message-ID: <20120622060657.GA15213@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 02:17:32PM -0600, Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > Device tree support for the TPS6586x PMU used on Harmony has recently
> > been added. This commit adds the required device tree nodes to probe the
> > PMU from the device tree.
> 
> > diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> 
> > +		tps6586x at 34 {
> > +			compatible = "ti,tps6586x";
> > +			reg = <0x34>;
> > +			interrupts = <0 88 0x4>;
> 
> I believe that should be interrupt 86 not 88.

Yes, you're absolutely correct.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120622/4b5c3dc3/attachment.sig>
