From: B04825@freescale.com (Tabi Timur-B04825)
Date: Mon, 5 Mar 2012 12:28:52 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120305073930.GC16232@S2101-09.ap.freescale.net>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
 <20120305073930.GC16232@S2101-09.ap.freescale.net>
Message-ID: <4F54B183.4080607@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Yeah, it makes the diff neat.  However I would make it an inline
> function which is easier to play.

However you want to do it is fine with me, although I would use "u32 
__iomem *addr" instead of "void __iomem *addr".

-- 
Timur Tabi
Linux kernel developer at Freescale
