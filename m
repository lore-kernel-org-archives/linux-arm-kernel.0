From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 25 Aug 2015 23:47:24 +0200
Subject: [GIT PULL] ARM64: juno: SCPI and dependent drivers for v4.3
In-Reply-To: <20150821161732.GC14452@localhost>
References: <55C1E3FB.5090309@arm.com> <55CCAF50.4040503@arm.com>
 <20150821161732.GC14452@localhost>
Message-ID: <10834223.pThsip28PI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, 21. August 2015, 09:17:32 schrieb Olof Johansson:
> > >PSCI only covers CPU boot/cpuidle and platform suspend. It does not have
> > >any provisions for DVFS and I'm not sure this could be easily
> > >standardised (or whether we could find enough supporters to get it
> > >adopted).
> > 
> > Though we are not campaigning it as aggressively as PSCI.
> 
> Which, given the resistance to pick up PSCI, this is unlikely to be used by
> anyone...

Rockchip seems to use SCPI to offload ddr frequency to a mcu scaling on the 
rk3368 ;-)


Heiko
