From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Jun 2014 14:22:44 +0800
Subject: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
In-Reply-To: <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
References: <20140624153559.GA5741@dragon>
 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
Message-ID: <20140625062243.GD3242@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 04:37:19PM -0300, Fabio Estevam wrote:
> On Tue, Jun 24, 2014 at 12:36 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Hi Lucas,
> >
> > I found that imx6q suspend/resume is broken on 3.16-rc, and it works
> > just fine if PCIe support is built out.  However the issue was not
> > exposed on 3.15, so I suspect the PCIe driver change merged in 3.16
> > is part of the cause.
> 
> I have just tested this on linux-next and I see that suspend/resume
> fails even if I build a kernel without PCI support.

Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
should be another issue.

Shawn
