From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Jun 2014 16:37:19 -0300
Subject: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
In-Reply-To: <20140624153559.GA5741@dragon>
References: <20140624153559.GA5741@dragon>
Message-ID: <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 12:36 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Lucas,
>
> I found that imx6q suspend/resume is broken on 3.16-rc, and it works
> just fine if PCIe support is built out.  However the issue was not
> exposed on 3.15, so I suspect the PCIe driver change merged in 3.16
> is part of the cause.

I have just tested this on linux-next and I see that suspend/resume
fails even if I build a kernel without PCI support.
