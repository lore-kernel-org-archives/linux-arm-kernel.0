From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 13 Feb 2017 14:52:57 +0530
Subject: [PATCH 00/10] ARM: davinci: add vpif display support
In-Reply-To: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <058423ca-c53b-93a2-035e-54fe3ce6dcfe@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Tuesday 07 February 2017 10:11 PM, Bartosz Golaszewski wrote:
> The following series adds support for v4l2 display on da850-evm with
> a UI board in device tree boot mode.
> 
> Patches 1/10 - 5/10 deal with the device tree: we fix whitespace
> errors in dts files and bindings, extend the example and the dts for
> da850-evm with the output port and address the pinmuxing.
> 
> Patch 6/10 enables the relevant modules in the defconfig file.
> 
> Patches 7/10 and 8/10 fix two already existing bugs encountered
> during development.
> 
> Patch 9/10 make it possible to use a different i2c adapter in the
> vpif display driver.
> 
> The last patch adds the pdata quirks necessary to enable v4l2 display.
> 
> Tested with a modified version of yavta[1] as gstreamer support for
> v4l2 seems to be broken and results in picture artifacts.
> 
> [1] https://github.com/brgl/yavta davinci/vpif-display

Can you also share the command line you used ?

Thanks,
Sekhar
