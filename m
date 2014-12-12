From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 12 Dec 2014 10:40:22 +0800
Subject: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C
 controller
In-Reply-To: <20141127164536.GC5667@katana>
References: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
 <20141124121555.GG3733@katana> <1417096856.12707.59.camel@mtksdaap41>
 <20141127164536.GC5667@katana>
Message-ID: <1418352022.4994.44.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-11-27 at 17:45 +0100, Wolfram Sang wrote:
> > > I think there are now 3 drivers in my queue which are not fully I2C
> > > compatible but more supporting the very minimum to, say, read an eeprom.
> > > I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
> > > think about ways how to communicate deficiencies like "only 255 byte" or
> > > "only WRRD messages" to users of that I2C controller. This is most
> > > likely not happening before 3.19. But assistance is very welcome.

Hi Wolfram,

We've started upstream work for MT8173[1].

We've fixed these issues for new SoC, and we believe it is fully I2C
compatible now. We'll add mt8173 support to this driver, so this driver
will support both fully I2C compatible SoC and the current one.

Joe.C

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309847.html
