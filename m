From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 14 Sep 2017 19:16:45 +0200
Subject: [PATCH 0/3] SoM1 EK board fixes
In-Reply-To: <6071a97c-6879-8de0-2f05-22d993becd0c@microchip.com>
References: <1505399294-20041-1-git-send-email-claudiu.beznea@microchip.com>
 <6071a97c-6879-8de0-2f05-22d993becd0c@microchip.com>
Message-ID: <20170914171645.td5lx3mdfidtmcde@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/2017 at 19:00:13 +0200, Nicolas Ferre wrote:
> On 14/09/2017 at 16:28, Claudiu Beznea wrote:
> > Hi,
> > 
> > This series contains fixes for SAMA5D27 SoM1 EK board. It would be
> > good if we will have this in 4.14 version.
> > 
> > Thank you,
> > Claudiu
> > 
> > Ludovic Desroches (2):
> >   ARM: dts: at91: sama5d27_som1_ek: update pinmux/pinconf for LEDs and
> >     USB
> >   ARM: dts: at91: sama5d27_som1_ek: fix typos
> 
> Additional:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> For those 2.
> 
> I merged them in a at91-4.14-fixes branch here:
> https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git/log/?h=at91-4.14-fixes
> 
> and merge it in at91-next. It should appear in tomorrow's linux-next.
> 
> Alexandre, do you agree with these 3 patches for fixes? Do you see other
> patches to add to this "-fixes" branch? like:
> ARM: at91: Replace uses of virt_to_phys with __pa_symbol
> ...
> 
> Do you want me to do the RP while you are at "Linux plumbers"?
> 

You can't send any PR this week because 4.14-rc1 has not been released
yet. You can't base your PR on anything useful...


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
