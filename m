From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 13 Dec 2016 18:36:48 +0100
Subject: [PATCH 9/9] arm64: dts: rockchip: add regulator info for Kevin
 digitizer
In-Reply-To: <1480645653-36943-10-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <1480645653-36943-10-git-send-email-briannorris@chromium.org>
Message-ID: <2884868.1AkzspAEPR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. Dezember 2016, 18:27:33 CET schrieb Brian Norris:
> We need to enable this regulator before the digitizer can be used. Wacom
> recommended waiting for 100 ms before talking to the HID.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Uses WIP bindings:
> 
> [PATCH v3 1/2] devicetree: i2c-hid: Add regulator support
> https://patchwork.kernel.org/patch/9457493/

if you notice the bindings being accepted before me, could you notify here 
please?


Thanks
Heiko
