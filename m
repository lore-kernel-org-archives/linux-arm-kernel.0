From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 May 2014 11:02:31 -0300
Subject: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
In-Reply-To: <1399885183.5016.4.camel@weser.hi.pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <20140424175844.GD29593@google.com>
 <1398421265.4657.25.camel@weser.hi.pengutronix.de>
 <CAErSpo7Boi8d+apAUC3TmmE33LuRMYJ6J+TEPLRbeyZyU3O8RQ@mail.gmail.com>
 <1398774686.4677.12.camel@weser.hi.pengutronix.de>
 <1399885183.5016.4.camel@weser.hi.pengutronix.de>
Message-ID: <CAOMZO5BAcZi5dKvitPxqcWnB=J1LY7sDRxiDcxRAjZmSpGZBEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Mon, May 12, 2014 at 5:59 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Bjorn,
>
> just a friendly reminder. It would be nice if you could pull those in.
>
> Shawn already pulled the DT change and as it is a binding change this
> means PCIe on i.MX6 is broken in -next, as long as the remaining patches
> are missing.

We still have imx6q pcie broken in linux-next:

imx6q-pcie 1ffc000.pcie: lvds_gate clock select missing or invalid
imx6q-pcie: probe of 1ffc000.pcie failed with error -2


Could you please apply Lucas' series?
