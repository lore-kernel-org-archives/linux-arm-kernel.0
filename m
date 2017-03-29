From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Mar 2017 11:40:57 +0800
Subject: [PATCH v2 00/15] ARM: dts: i.MX6: Add lcdif/sound nodes on
 Engicam SOMs
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <20170329034055.GY30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 09:48:35PM +0530, Jagan Teki wrote:
> Jagan Teki (15):
>   ARM: dts: imx6ul-geam: Add backlight support for lcdif
>   ARM: dts: imx6ul-isiot: Add backlight support for lcdif
>   ARM: dts: imx6ul-isiot: Add imx6ul-isiot-common.dtsi
>   ARM: dts: imx6ul-isiot: Add i2c nodes
>   ARM: dts: imx6ul-isiot-common: Add touchscreen node
>   ARM: dts: imx6ul-[geam|isiot]: Add sai2 node

Applied above ones.

Shawn

>   ARM: dts: imx6ul-isiot: Add Sound card with codec node
>   ARM: dts: imx6ul-geam: Add Sound card with codec node
>   ARM: dts: imx6qdl-icore: Add Sound card with codec node
>   ARM: dts: imx6dl-icore-rqs: Add sgtl5000 codec node
>   ARM: dts: imx6qdl-icore-rqs: Replace codec 'lable: node at addr'
>   ARM: dts: imx6dl-icore: Add LVDS support
>   ARM: dts: imx6dl-icore: Add touchscreen node
>   ARM: dts: imx6qdl-icore-rqs: Add CAN nodes
>   ARM: dts: imx6ul-isiot: Add FEC node support
