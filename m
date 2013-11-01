From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 20:07:03 +0800
Subject: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
In-Reply-To: <20131101102805.GG28401@MrMyself>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101102805.GG28401@MrMyself>
Message-ID: <20131101120700.GE10324@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 06:28:05PM +0800, Nicolin Chen wrote:
> >  sound/soc/fsl/fsl-sgtl5000-vf610.c | 208 +++++++++++++++++++++++++++++++++++++
> 
> I just doubt if this file naming is appropriate. Even if we might not have
> rigor rule for the file names, according to existing ones, they are all in
> a same pattern: [SoC name]-[codec name].c
> 
> "imx-sgtl5000.c" for example
> 
> I think it would make user less confused about what this file exactly is if
> this machine driver also follow the pattern: vf610-sgtl5000.c
> 
> 
> @Shawn
> 
> What do you think about the file name?

Yeah, it would be better to name the file following the existing the
pattern.

Shawn
