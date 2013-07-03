From: b32955@freescale.com (Huang Shijie)
Date: Wed, 3 Jul 2013 10:15:36 +0800
Subject: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
In-Reply-To: <20130702111118.GE31358@e106331-lin.cambridge.arm.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-4-git-send-email-b32955@freescale.com>
 <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
 <51D2AEC1.6030004@freescale.com>
 <20130702111118.GE31358@e106331-lin.cambridge.arm.com>
Message-ID: <51D38948.4040606@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?02? 19:11, Mark Rutland ??:
> compatible string ("fsl,imx21-uart") that should not break newer
> kernels if they choose to use the more-specific compatible string.
>
ok.

I will add back the the "fsl,imx21-uart".

thanks for the review.

Huang Shijie
