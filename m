From: zhi.mao@mediatek.com (Zhi Mao)
Date: Wed, 2 Aug 2017 15:19:54 +0800
Subject: [PATCH v3 0/6] mediatek: pwm driver add MT2712/MT7622 support
In-Reply-To: <1500261364.22478.32.camel@mhfsdcap03>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1500261364.22478.32.camel@mhfsdcap03>
Message-ID: <1501658394.22478.36.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John, Matthais & Thierry,
> 
> Just a gentle ping on this issue again.
> Do you have any update?
> 
> Regards,
> Zhi


On Mon, 2017-07-17 at 11:16 +0800, Zhi Mao wrote:
> Hi John, Matthais & PWM Maintainers
> 
> Just a Gentle ping on this issue :)
> Is there anything should be modified?
> 
> Regards,
> Zhi
> 
> 
> On Fri, 2017-06-30 at 14:05 +0800, Zhi Mao wrote:
> > change in v3:
> > 1. add pwm clk disable in function:mtk_pwm_config()
> >    for error parameter checking case
> > 
> > Zhi Mao (6):
> >   pwm: kconfig: modify mediatek information
> >   pwm: mediatek: fix pwm source clock selection
> >   pwm: mediatek: fix clock control issue
> >   pwm: bindings: add MT2712/MT7622 information
> >   pwm: mediatek: add PWM_CLK_DIV_MAX
> >   pwm: mediatek: add MT2712/MT7622 support
> > 
> >  .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
> >  drivers/pwm/Kconfig                                |    2 +-
> >  drivers/pwm/pwm-mediatek.c                         |  133 ++++++++++++++------
> >  3 files changed, 104 insertions(+), 37 deletions(-)
> > 
> 
