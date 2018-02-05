From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 18:58:39 +0800
Subject: [PATCH v3 0/7] ARM: dts: imx6q: engicam LVDS panel changes
In-Reply-To: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20180205105838.GZ31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 04, 2018 at 11:19:24PM +0530, Jagan Teki wrote:
> Series adda LVDS panel attributes on panel drivers instead of defining
> them in dts nodes, and also added new icorem6 engicam boards.
> 
> Jagan Teki (7):
>   drm/panel: simple: add support for Ampire AM-800480AYTZQW-00H
>   ARM: dts: imx6q-icore: Switch LVDS timings from panel-simple
>   ARM: dts: imx6dl-icore: Add LVDS node
>   drm/panel: simple: Add support for KEO TX31D200VM0BAA
>   ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings from panel-simple
>   ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 7
>     initial support
>   ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit
>     support
> 
>  .../display/panel/ampire,am-800480aytzqw-00h.txt   | 25 +++++++++
>  .../bindings/display/panel/koe,tx31d200vm0baa.txt  | 25 +++++++++
...
>  drivers/gpu/drm/panel/panel-simple.c               | 54 ++++++++++++++++++

The dts files should really be sent only after above bindings doc and
driver changes get merged first.

Shawn
