From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Tue, 3 Apr 2018 14:23:50 +0200
Subject: [PATCH v9 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <1520302562-1577-1-git-send-email-yong.deng@magewell.com>
References: <1520302562-1577-1-git-send-email-yong.deng@magewell.com>
Message-ID: <218b07cd-4490-517e-1dff-ada7d73dfcf1@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/18 03:16, Yong Deng wrote:
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
> 
> This patch implement a v4l2 framework driver for it.
> 
> Currently, the driver only support the parallel interface. MIPI-CSI2,
> ISP's support are not included in this patch.
> 
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans
