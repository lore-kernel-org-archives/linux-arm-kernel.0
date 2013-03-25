From: avinashphilip@ti.com (Philip, Avinash)
Date: Mon, 25 Mar 2013 08:30:45 +0000
Subject: [PATCH v3 0/3] Platform support for EHRPWM & ECAP devices in
 DAVINCI.
In-Reply-To: <5150076D.3080904@ti.com>
References: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
 <5150076D.3080904@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EAA19F4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 13:44:37, Nori, Sekhar wrote:
> On 3/25/2013 1:19 PM, Philip Avinash wrote:
> > Add platform support for EHRPWM and ECAP by providing clock nodes and
> > device tree nodes.
> > This series depends on [1] and [2] and is available for testing at [3].
> > Tested for back light support in da850 EVM with EHRPWM PWM device.
> > 
> > [1] http://gitorious.org/linux-davinci/linux-davinci/trees/davinci-for-v3.9/dt-2
> > [2] https://gitorious.org/linux-pwm/linux-pwm/trees/for-next
> > [3] https://github.com/avinashphilip/am335x_linux/tree/davinci-for-v3.9_soc_pwm
> > 
> > Note:
> > DT support for EHRPWM backlight has not been added in da850-evm.dts as there is
> > conflicting pin-mux requirement with SPI flash.
> > 
> > Philip Avinash (3):
> >   ARM: davinci: clk framework support for enable/disable functionality
> 
> Patch 1/3 did not reach me. I cant find it in archives either so most
> likely no one received it. Can you please send that one patch again?

Done.

> 
> >   arm: davinci: clock node support for ECAP & EHRPWM
> 
> For future, please be consistent and capitalize 'ARM' in subject line.

Ok I will take care.

Thanks
Avinash
> 
> >   ARM: davinci: da850: add EHRPWM & ECAP DT node
> > 
> >  arch/arm/boot/dts/da850.dtsi               |   30 ++++++++++++++++++
> >  arch/arm/mach-davinci/clock.c              |   21 ++++++++-----
> >  arch/arm/mach-davinci/clock.h              |    2 ++
> >  arch/arm/mach-davinci/da850.c              |   46 ++++++++++++++++++++++++++++
> >  arch/arm/mach-davinci/da8xx-dt.c           |    5 +++
> >  arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
> >  6 files changed, 98 insertions(+), 7 deletions(-)
> > 
> 
> Thanks,
> Sekhar
> 
