From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 10:44:19 -0700
Subject: [GIT PULL] ARM: bcm SOC  for 3.12
In-Reply-To: <5213B68F.4050800@broadcom.com>
References: <5213B68F.4050800@broadcom.com>
Message-ID: <20130829174419.GG18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 11:33:51AM -0700, Christian Daudt wrote:
> Hi Arnd, Olof,
>  Please pull the branch below. It contains various SOC related
> cleanups for BCM arch.
> 
>  Thanks,
>    csd
> 
> The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:
> 
>   Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/broadcom/bcm11351.git armsoc/for-3.12/soc
> 
> for you to fetch changes up to 3a76b35186cb967a69c4a3935caf2fdf428e933b:
> 
>   ARM: bcm: Make secure API call optional (2013-08-20 10:51:39 -0700)
> 
> ----------------------------------------------------------------
> SoC changes for 3.12 BCM
> 
> ----------------------------------------------------------------
> Christian Daudt (4):
>       ARM: bcm: Rename board_bcm
>       ARM: mmc: fix NONREMOVABLE test in sdhci-bcm-kona

This is mislabelled. It's mmc: not ARM: mmc:. And like below, it should have
been acked by Chris.

>       ARM: DT: binding fixup to align with vendor-prefixes.txt (drivers)
>       ARM: bcm: Make secure API call optional
> 
> Markus Mayer (4):
>       ARM: bcm281xx: Turn on L2 cache.
>       ARM bcm281xx: Turn on socket & network support.

Nit: misformatted subject line.

>       ARM: bcm281xx: Board specific reboot code
>       mmc: sdhci-bcm-kona: make linker-section warning go away

This one should have had an ack from Chris Ball. I pinged him over IRC
about it and he's ok with it going in here, but please collect acks in
the future.


I've pulled in the branch but please be mindful of the above in the future.


-Olof
