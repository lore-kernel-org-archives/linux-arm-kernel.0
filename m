From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 17:39:48 +0200
Subject: [GIT PULL] at91: fixes for 4.14 #2
In-Reply-To: <20171009142602.8027-1-nicolas.ferre@microchip.com>
References: <20171009142602.8027-1-nicolas.ferre@microchip.com>
Message-ID: <CAK8P3a0HM78v748JXRsXtW0s=4LCz6KDPxANtGErKv0Z1KMefw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 9, 2017 at 4:26 PM, Nicolas Ferre
<nicolas.ferre@microchip.com> wrote:
> Arnd, Olof,
>
> A second batch of fixes for AT91, all about DT modifications. We discovered
> the Ethernet phy issue lately and the ADC fixes are patches that we forgot
> while converting sama5d2 ADC to use hardware triggers. The 2 ADC patches are
> needed so that the driver can probe corectly again:
> https://storage.kernelci.org/mainline/master/v4.14-rc2-255-g74d83ec2b734/arm/sama5_defconfig/lab-free-electrons/boot-at91-sama5d2_xplained.txt
> It will certainly be the last "fixes" PR for this cycle.

Pulled into fixes, thanks and sorry for the delay.

      Arnd
