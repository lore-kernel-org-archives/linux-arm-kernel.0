From: Josh.wu@atmel.com (Wu, Josh)
Date: Sat, 22 Oct 2011 14:41:08 +0800
Subject: [PATCH v4 1/3] [media] at91: add code to enable/disable ISI_MCK
	clock
In-Reply-To: <Pine.LNX.4.64.1110171702370.18438@axis700.grange>
References: <1318331020-22031-1-git-send-email-josh.wu@atmel.com>
	<1318331020-22031-2-git-send-email-josh.wu@atmel.com>
	<Pine.LNX.4.64.1110171702370.18438@axis700.grange>
Message-ID: <4C79549CB6F772498162A641D92D5328031B11E0@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Guennadi

On Monday, October 17, 2011 11:04 PM, Guennadi Liakhovetski wrote:

> From: Josh Wu <josh.wu@atmel.com>
>
> This patch
> - add ISI_MCK clock enable/disable code.
> - change field name in isi_platform_data structure
>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> [g.liakhovetski at gmx.de: fix label names]
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

> Josh, I missed a slight hick-up in the previous version of this your 
> patch, so, I fixed it myself. Please confirm, that this version is ok
with 
> you.

> Thanks
> Guennadi

I confirm that the patch is ok for me. Thank you.

Best Regards,
Josh Wu
