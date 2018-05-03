From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 3 May 2018 10:06:57 +0530
Subject: [PATCH V4 3/3] cpufreq: add suspend/resume support in Armada
 37xx DVFS driver
In-Reply-To: <87r2mu8382.fsf@bootlin.com>
References: <e98965068836e673ea826e8a03fd01e168fce3ed.1524561482.git.viresh.kumar@linaro.org>
 <cover.1524737432.git.viresh.kumar@linaro.org>
 <d6be605205f6af01968a99582b05026aec2eca42.1524737432.git.viresh.kumar@linaro.org>
 <87r2mu8382.fsf@bootlin.com>
Message-ID: <20180503043657.4ufzqcxuqogx34mk@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-05-18, 17:52, Gregory CLEMENT wrote:
> Hi Viresh,
>  
>  On jeu., avril 26 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Add suspend/resume hooks in Armada 37xx DVFS driver to handle S2RAM
> > operations. As there is currently no 'driver' structure, create one
> > to store both the regmap and the register values during suspend
> > operation.
> 
> I tested this patch on a Armada 3720 based board (EspressoBin), and it
> worked well. I even made some power consumption measurement and after
> the resume, the power consumption had the same value that before the
> suspend, for low CPU frequency and high CPU frequency.
> 
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks Gregory.

-- 
viresh
