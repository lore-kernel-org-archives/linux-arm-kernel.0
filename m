From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jun 2014 07:50:47 -0300
Subject: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
In-Reply-To: <20140625062243.GD3242@dragon>
References: <20140624153559.GA5741@dragon>
 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
 <20140625062243.GD3242@dragon>
Message-ID: <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 3:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
> should be another issue.

Yes, I see it now. Tested on -rc2 and suspend/resume works with PCI
driver removed.
