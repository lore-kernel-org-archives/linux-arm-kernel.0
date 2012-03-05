From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Mar 2012 21:40:51 +0800
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F54B183.4080607@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
 <20120305073930.GC16232@S2101-09.ap.freescale.net>
 <4F54B183.4080607@freescale.com>
Message-ID: <20120305134048.GG16232@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 12:28:52PM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Yeah, it makes the diff neat.  However I would make it an inline
> > function which is easier to play.
> 
> However you want to do it is fine with me, although I would use "u32 
> __iomem *addr" instead of "void __iomem *addr".
> 
Right, will make the change. 

-- 
Regards,
Shawn
