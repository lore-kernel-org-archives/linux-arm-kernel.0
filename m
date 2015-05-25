From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 25 May 2015 10:14:51 +0800
Subject: [PATCH v2 0/2] Add MediaTek display PWM driver
In-Reply-To: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <1432520091.23308.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-21 at 21:29 +0800, YH Huang wrote:
> YH Huang (2):
>   dt-bindings: pwm: add MediaTek display PWM bindings
>   pwm: add MediaTek display PWM driver support
> 
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  25 +++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-mtk-disp.c                         | 228 +++++++++++++++++++++
>  4 files changed, 264 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c

Hi YH,

It would be easier for reviewer if you have a summary here on what you
have changed compare to last version.
Also, please add patch series summary even for v2, it remind reviewer
what this series is about.

Joe.C
