From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Jun 2015 10:46:29 -0300
Subject: [GIT PULL 3/4] ARM: imx: device tree changes for 4.2
In-Reply-To: <20150602033337.GA7571@dragon>
References: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
 <1433145206-2508-3-git-send-email-shawn.guo@linaro.org>
 <3918834.Y7ttkc5iBm@wuerfel>
 <CAOMZO5Co4w7AU7xLP1yq5gqkO0H8RdkxGSvoK-=62m62LEDkJg@mail.gmail.com>
 <20150602033337.GA7571@dragon>
Message-ID: <CAOMZO5B_74HgFZqiRWrJXs6BSStfJHB6wicjdUQ4MTAk=SvG=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 12:33 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> So here is my changes to fix all the errors reported by Stephen, except
> 'SZ_4K' one.  Let me know if it's preferred or we'd like to drop
> COMPILE_TEST and simply depend on ARCH_MXC.

I would say that we could drop COMPILE_TEST and use 'depends on
ARCH_MXC' instead.

Regards,

Fabio Estevam
