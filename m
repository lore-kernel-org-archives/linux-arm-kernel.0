From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 30 Oct 2014 22:49:05 +0800
Subject: [PATCH 3/3] I2C: mediatek: Add driver for MediaTek I2C controller
In-Reply-To: <20141030132537.GB23852@katana>
References: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
 <1414561058-23803-4-git-send-email-xudong.chen@mediatek.com>
 <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w@mail.gmail.com>
 <20141030132537.GB23852@katana>
Message-ID: <1414680545.5833.21.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-30 at 14:25 +0100, Wolfram Sang wrote:
> > > +obj-$(CONFIG_I2C_MT65XX)       += i2c-mt65xx.o
> > 
> > As it works for mt65xx and mt81xx series, better rename it to i2c-mtk.c
> 
> That is a bit too generic IMO. It is likely that we will see some
> totally different I2C core from MTK in the future. Plus, it is not
> uncommon that a driver initially for SoC-X supports SoC-Y, too.

Hi,

Yes, MTK TV SoCs(MT53xx) do use a different/incompatible I2C IP. So we
preferred to keep original file name.

Joe.C 
