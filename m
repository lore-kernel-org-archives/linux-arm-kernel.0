From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 1 May 2018 11:53:00 -0700
Subject: [GIT PULL 1/3] bcm2835-dt-next-2018-04-30
In-Reply-To: <20180430212750.12303-1-eric@anholt.net>
References: <20180430212750.12303-1-eric@anholt.net>
Message-ID: <1f75527c-7e44-15e6-114f-a15e0bbd11ba@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2018 02:27 PM, Eric Anholt wrote:
> Hi Florian,
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2018-04-30
> 
> for you to fetch changes up to bdd6d1fe1cd84806429467ce62a735bdc6bdbae7:
> 
>   arm64: dts: broadcom: Add reference to Raspberry Pi 3 B+ (2018-04-23 15:03:07 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in Raspberry Pi 3 B+ support and connects
> HDMI hotplug, LEDs, and wifi/bluetooth on the Raspberry Pi 3.
> 
> ----------------------------------------------------------------
> Stefan Wahren (5):
>       ARM: dts: bcm283x: Fix PWM pin assignment
>       ARM: dts: bcm2837: Add missing GPIOs of Expander
>       dt-bindings: bcm: Add Raspberry Pi 3 B+
>       ARM: dts: bcm2837: Add Raspberry Pi 3 B+
>       arm64: dts: broadcom: Add reference to Raspberry Pi 3 B+

Merged into devicetree/next, thanks Eric!
--
Florian
