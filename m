From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 23 Jul 2018 12:41:00 +0000
Subject: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
In-Reply-To: <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
 <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
Message-ID: <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-07-20 at 08:33 -0700, Andrey Smirnov wrote:
> On Fri, Jul 20, 2018 at 5:48 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > 
> > This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
> > 
> > That commit followed the reference manual but unfortunately the imx7d
> > manual is incorrect.
> 
> I'd also add similar comment to DT file to prevent people from trying
> to "fix" this in the future.

I'll try to see if I can follow up internally with docs team to get
this updated in the next revision of the reference manual.

> Also, this change is going to break QEMU's mapping found here:

I had no idea that existed, I guess somebody needs to fix that as well.

Do you have an imx7d board using pci or did you just test in emulation?

--
Regards,
Leonard
