From: david@lechnology.com (David Lechner)
Date: Tue, 26 Jun 2018 11:51:00 -0500
Subject: [PATCH 0/2] ARM: LEGO MINDSTORMS EV3 Bluetooth support
In-Reply-To: <20180531202549.11255-1-david@lechnology.com>
References: <20180531202549.11255-1-david@lechnology.com>
Message-ID: <a448b752-e32c-d5a8-7f11-57a14b63ba8a@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 05/31/2018 03:25 PM, David Lechner wrote:
> This series adds Bluetooth support to LEGO MINDSTORMS EV3.
> 
> The pwm-clock depends on the common clock framework, so this requires the
> recent davinci common clock series to switch to the common clock framework
> before it will actually work.
> 
> David Lechner (2):
>    ARM: dts: da850-lego-ev3: Add Bluetooth nodes
>    ARM: davinci_all_defconfig: Enable Bluetooth
> 
>   arch/arm/boot/dts/da850-lego-ev3.dts   | 82 ++++++++++++++++++++++++++
>   arch/arm/configs/davinci_all_defconfig |  9 +++
>   2 files changed, 91 insertions(+)
> 

After "ARM: dts: da850: Add power-domains to PWM nodes", this is ready to
apply.
