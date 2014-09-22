From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 22 Sep 2014 15:46:12 -0400
Subject: 
In-Reply-To: <1411414879-11551-1-git-send-email-santosh.shilimkar@ti.com>
References: <1411414879-11551-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <54207C84.3050103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Ignore this email... I resent it with $subject line fixed)

On Monday 22 September 2014 03:41 PM, Santosh Shilimkar wrote:
> Subject: [GIT PULL] ARM: dts: Keystone DTS updates for 3.18
> 
> Hi Arm-soc folks,
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts
> 
> for you to fetch changes up to b2ed7d98e1c7098f452cf95ab69211a2f8e02ac8:
> 
>   ARM: dts: keystone: fix bindings for pcie and usb clock nodes (2014-09-22 15:19:36 -0400)
> 
> ----------------------------------------------------------------
> Keystone DTS updates for v3.18
> 
> - Add IRQ and GPIO nodes
> - Fix SPI chip select
> - Fix usb and pcie clock nodes
> 
> ----------------------------------------------------------------
> Grygorii Strashko (2):
>       ARM: dts: keystone: add keystone irq controller node
>       ARM: dts: keystone: add dsp gpio controllers nodes
> 
> Karicheri Muralidharan (1):
>       ARM: dts: keystone: k2l: Fix chip selects for SPI devices
> 
> Karicheri, Muralidharan (1):
>       ARM: dts: keystone: fix bindings for pcie and usb clock nodes
> 
>  arch/arm/boot/dts/k2e-clocks.dtsi |    6 ++--
>  arch/arm/boot/dts/k2e.dtsi        |    7 +++++
>  arch/arm/boot/dts/k2hk.dtsi       |   56 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/k2l.dtsi        |   42 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/keystone.dtsi   |    8 ++++++
>  5 files changed, 116 insertions(+), 3 deletions(-)
> 
