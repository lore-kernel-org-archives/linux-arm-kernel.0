From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 14:40:22 +0200
Subject: [PATCH v8 5/9] ARM: dts: am437x/am33xx/da850: Add new ECAP and
 EPWM bindings
In-Reply-To: <20160610120142.GK22406@atomide.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-6-git-send-email-fcooper@ti.com>
 <20160610103423.GT22406@atomide.com>
 <20160610120142.GK22406@atomide.com>
Message-ID: <20160610124022.GD27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 05:01:43AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160610 03:37]:
> > * Franklin S Cooper Jr <fcooper@ti.com> [160503 08:58]:
> > > Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
> > > provide the various required clocks.
> > > 
> > > For AM437 and AM335x, add the required clocks explicitly to DT. The
> > > hwmod entries for ECAP and EPWM will be removed and this will prevent
> > > anything from breaking.
> > 
> > I've applying the first patch into omap-for-v4.8/soc, the rest into
> > omap-for-v4.8/dt. Note that this patch did not apply against d850.dtsi
> > so please resend that change as a separate patch to the davinci
> > maintainer.
> 
> And I did not apply patch "pwms: pwm-ti*: Get the clock from the PWMSS
> parent when using old bindings", Thierry should take that one.

Tony, did you take patches 3 and 4 already? It's fine if yo have, just
wanted to know whether I should pick those up as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/a7eea9ba/attachment.sig>
