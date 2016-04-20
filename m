From: pc.liao@mediatek.com (PC Liao)
Date: Thu, 21 Apr 2016 00:27:44 +0800
Subject: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
In-Reply-To: <57178482.9090705@gmail.com>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
 <57178482.9090705@gmail.com>
Message-ID: <1461169664.8479.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Wed, 2016-04-20 at 21:30 +0800, Matthias Brugger wrote:
> 
> For compatibility you should change this to something like:
> 
>     dev_warn(card->dev, "Only one dai codec found in DTS, enabled rt5645
>                          AD filter\n");
>     rt5645_sel_asrc_clk_src(codec, RT5645_AD_STEREO_FILTER,
>                                    RT5645_CLK_SEL_I2S1_ASRC);
> }
> 

I will use this in next version.
Thanks!
