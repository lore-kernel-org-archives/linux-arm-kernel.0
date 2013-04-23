From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 23 Apr 2013 10:16:18 +0100
Subject: [RFC PATCH v2 12/13] ARM: mach-vt8500: cpus/cpu nodes dts updates
In-Reply-To: <5175EFFE.7020903@prisktech.co.nz>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-13-git-send-email-lorenzo.pieralisi@arm.com>
 <5175EE3E.7080809@prisktech.co.nz>
 <5175EFFE.7020903@prisktech.co.nz>
Message-ID: <20130423091618.GB22946@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 03:20:46AM +0100, Tony Prisk wrote:
> On 23/04/13 14:13, Tony Prisk wrote:
> > On 23/04/13 03:27, Lorenzo Pieralisi wrote:
> >> This patch updates the in-kernel dts files according to the latest cpus
> >> and cpu bindings updates for ARM.
> >>
> >> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> ---
> >>   arch/arm/boot/dts/wm8505.dtsi | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/wm8505.dtsi 
> >> b/arch/arm/boot/dts/wm8505.dtsi
> >> index e74a1c0..a470808 100644
> >> --- a/arch/arm/boot/dts/wm8505.dtsi
> >> +++ b/arch/arm/boot/dts/wm8505.dtsi
> >> @@ -13,7 +13,7 @@
> >>         cpus {
> >>           cpu at 0 {
> >> -            compatible = "arm,arm926ejs";
> >> +            compatible = "arm,arm926";
> >>           };
> >>       };
> > As the only author for that file, and the arch-vt8500 maintainer, a CC 
> > would have been nice :)
> >
> > This binding is still incomplete.device_type, compatible and reg are 
> > all required properties.
> > Also, you seem to have only fixed the wm8505.dtsi, while vt8500.dtsi, 
> > wm8650.dtsi and wm8850.dtsi are all left incorrect.
> >
> > I am already carrying a patch to fix all this properly so could you 
> > drop the arch-vt8500 related patch and I will send in a more complete 
> > version for 3.11
> >
> > Regards
> > Tony Prisk
> 
> I didn't notice the rules had been changed in the last patch - shouldn't 
> you be changing the rules (read: binding) before changing the devicetree 
> files?

Fair enough, point taken.

> Request still stands - please drop this patch and I will submit a more 
> complete one with the other SoCs updated as well.

Great, thanks,
Lorenzo
