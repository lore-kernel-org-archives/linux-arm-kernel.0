From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 11 Jan 2018 09:37:43 +0100
Subject: [PATCH] ARM64: dts: meson-axg: add RMII pins for ethernet
 controller
In-Reply-To: <20180111030411.197054-1-yixun.lan@amlogic.com>
References: <20180111030411.197054-1-yixun.lan@amlogic.com>
Message-ID: <1515659863.5048.112.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-01-11 at 11:04 +0800, Yixun Lan wrote:
> Comparing to RGMII interface, the RMII interface require few pins.
> So it's worth describing them here.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

The only axg platform we have upstream is the s400 and is using rgmii.
May I ask how this was tested ?
