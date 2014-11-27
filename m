From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 18:03:07 +0100
Subject: [GIT PULL] ARM: BCM5301X: DT changes for v3.19
In-Reply-To: <546E5A57.4030709@hauke-m.de>
References: <546299BC.4060704@hauke-m.de> <201411201038.07191.arnd@arndb.de>
 <546E5A57.4030709@hauke-m.de>
Message-ID: <2342514.nBdxGbXjBE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 22:17:11 Hauke Mehrtens wrote:
> On 11/20/2014 10:38 AM, Arnd Bergmann wrote:
> > On Wednesday 12 November 2014, Hauke Mehrtens wrote:
> >> ARM: BCM5301X: Add some more devices to device tree
> >>
> >> The most important part is adding the axi bus to the SoC dtsi file,
> >> this is the main bus on the SoC.
> >>
> >> These patches were all send to the arm list and I haven't got any
> >> negative responses.
> >>
> >> ----------------------------------------------------------------
> >> Hauke Mehrtens (1):
> >>       ARM: BCM5301X: activate early printk for Netgear R6250
> >>
> >> Rafa? Mi?ecki (2):
> >>       ARM: BCM5301X: Add Broadcom's bus-axi to the DTS file
> >>       ARM: BCM5301X: Add LEDs for Netgear R6250 V1
> >>
> > 
> > Same comments as for the SoC changes. Note that in general, enabling
> > 'earlyprintk' in the dts is a bad idea because it breaks booting a
> > kernel that has an incompatible debug_ll setting enabled, I'd rather
> > see you drop that patch.
> 
> Ok, I will drop that patch and resend a pull request, this time based on
> -rc1.

Have you sent it? I don't see a new pull request in my inbox.

	Arnd
