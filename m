From: zql@glomationinc.com (Zhong Li)
Date: Wed, 4 Dec 2013 10:54:11 -0500
Subject: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in DSP A mode
In-Reply-To: <529F1424.7040501@gmail.com>
References: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
 <1386124624-22414-3-git-send-email-voice.shen@atmel.com>
 <529F1424.7040501@gmail.com>
Message-ID: <075e01cef109$136c56f0$3a4504d0$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Richard Genoud
> Sent: Wednesday, December 04, 2013 6:38 AM
> To: Bo Shen
> Cc: zql at glomationinc.com; nicolas.ferre at atmel.com; alsa-devel at alsa-
> project.org; linux-sound at vger.kernel.org; broonie at kernel.org; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in DSP A
> mode
> 
> On 04/12/2013 03:37, Bo Shen wrote:
> > Change sam9x5 with wm8731 work in DSP A mode, this will fix the
> > left/right channel swap issue.
> >

> >
> Tested-by: Richard Genoud <richard.genoud@gmail.com> on at91sam9g35-ek
> with 3.12-rc2 + "ASoC: wm8731: fix dsp mode configuration"
> 
> 
> Thanks !
> 
> 

Where can I get a snap shot of your kernel source?  My test still have the
same issue after I applied the two patches.


Thanks,

Zhong
