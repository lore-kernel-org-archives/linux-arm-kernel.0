From: david@lechnology.com (David Lechner)
Date: Mon, 21 Nov 2016 11:04:48 -0600
Subject: [PATCH 0/2] ARM: davinvi: da850 add ohci DT nodes
In-Reply-To: <20161121165920.29809-1-ahaslam@baylibre.com>
References: <20161121165920.29809-1-ahaslam@baylibre.com>
Message-ID: <4d414c4d-3d08-f3d9-2bc5-aa90c8a631ce@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2016 10:59 AM, Axel Haslam wrote:
> This adds the DT node for the ohci controller and
> enables it for the omapl138-lckd platform.
>
> DEPENDENCIES:
>
> 1. [PATCH v6 0/5] USB: ohci-da8xx: Add device tree support
> https://lkml.org/lkml/2016/11/21/558
>
> 2. [PATCH v3 0/2] regulator: handling of error conditions for usb drivers
> https://lkml.org/lkml/2016/11/4/465
>
> Axel Haslam (2):
>   ARM: dts: da850: Add usb device node
>   ARM: dts: da850-lcdk: Enable ohci for omapl138 lcdk
>
>  arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
>  arch/arm/boot/dts/da850.dtsi     | 8 ++++++++
>  2 files changed, 16 insertions(+)
>

It does not look like you rebased these patches. Sekhar pushed the musb 
counterpart to v4.10/dt yesterday, which will cause conflicts with this 
series.

https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=v4.10/dt
