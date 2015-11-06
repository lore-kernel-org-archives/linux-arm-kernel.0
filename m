From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 06 Nov 2015 20:03:24 +0100
Subject: [PATCH v2 0/9] Better compatible for the rockchip thermal and
 support RK3368 SoCs
In-Reply-To: <20151106184739.GA8202@localhost.localdomain>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <20151106184739.GA8202@localhost.localdomain>
Message-ID: <1509087.903MXQEqfv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo, Caesar,

Am Freitag, 6. November 2015, 10:47:40 schrieb Eduardo Valentin:
> On Thu, Nov 05, 2015 at 01:17:56PM +0800, Caesar Wang wrote:
> > This series patchs are working for RK3368 on Rockchip platform.
> > 
> 
> Good to see the perseverance! :-)
> 
> > @Heiko,
> >     The PATCH [5/6] is working based on big/littel cluster cpufreq
> >     added. Anyway, the PATCH [5/6] also work for next kernel.
> > 
> > @Eduardo,
> > This patchset are based on linus master branch.
> > Note: Need add the following thermal patchs for thermal driver before 
apply
> > this series patchs.
> > 
> > 1) thermal: rockchip: fix handling of invalid readings
> > (https://patchwork.kernel.org/patch/6973101/)
> > 
> > 2) thermal: rockhip: fix setting thermal shutdown polarity
> > (https://patchwork.kernel.org/patch/6973131/)
> > 
> > 3) dt-bindings: rockchip-thermal: Add the pinctrl states in this document
> > (https://patchwork.kernel.org/patch/7472021/)
> > 
> > 4) thermal: rockchip: support the sleep pinctrl state to avoid glitches in 
s2r
> > (https://patchwork.kernel.org/patch/7472051/)
> > 
> > I'm glad these patchs have merged in thermal-soc git tree which can be 
found at
> > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
thermal.git
> 
> Yeah, apologize the delay on giving you a feedback on your code. As I
> mentioned before, I had a couple of other things in past weeks that
> consumed my time. 
> 
> Anyways, this specific patch series looks way better now that you have
> split it further. I will have a better look on it again and let you
> know when it will land.

I call dibs on the devicetree patches :-) .

Code and dt parts are very much separate, so I'd like to take the dt parts 
though my tree and arm-soc to keep further dts changes together.
Of course only once you are ok with the code parts :-)

Devicetree parts themselfs look ok to me.

Heiko
