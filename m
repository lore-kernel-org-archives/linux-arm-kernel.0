From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 26 Nov 2012 11:41:43 +0000
Subject: [PATCH 0/2] ARM/ASoC: Davinci: Device Tree Update
In-Reply-To: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAD78D4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Nov 22, 2012 at 09:34:57, Hebbar, Gururaja wrote:
> From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
> 
> 1. Add pinctrl for McASP Module
> 2. Add DT support for Davinci machine platform (resend)
> 
> Second commit is a resend after re-basing on latest broonie-asoc/for-next
> (v3.7-rc6)
> 
> Hebbar, Gururaja (2):
>   ASoC: davinci-mcasp: Add pinctrl support
>   ASoC: Davinci: machine: Add device tree binding

With these 2 patches, DT support for Davinci ASoC will be complete 
(well almost because edma dt binding is yet to be added). 
However it will at least be complete on Davinci platform.

Can you please review them and if it's OK, Could you please accept this series?

> 
>  .../bindings/sound/davinci-evm-audio.txt           |   66 +++++++
>  sound/soc/davinci/davinci-evm.c                    |  185 +++++++++++++++++---
>  sound/soc/davinci/davinci-mcasp.c                  |    7 +
>  3 files changed, 238 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
> 
> -- 
> 1.7.9.5
> 
> 


Regards, 
Gururaja
