From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 10 Dec 2013 09:45:44 +0800
Subject: [PATCH v5 09/15] usb: phy-mxs: Enable IC fixes for related SoCs
In-Reply-To: <52A592E1.7040506@pengutronix.de>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-10-git-send-email-peter.chen@freescale.com>
 <52A58179.2050702@pengutronix.de>
 <20131209090749.GB5291@shlinux1.ap.freescale.net>
 <52A592E1.7040506@pengutronix.de>
Message-ID: <20131210014543.GA24228@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 10:52:33AM +0100, Marc Kleine-Budde wrote:
> On 12/09/2013 10:07 AM, Peter Chen wrote:
> > On Mon, Dec 09, 2013 at 09:38:17AM +0100, Marc Kleine-Budde wrote:
> >> On 12/09/2013 07:30 AM, Peter Chen wrote:
> >>> Some PHY bugs are fixed by IC logic, but these bits are not
> >>> enabled by default, so we enable them at driver.
> >>
> >> Which bugs are fixed by enabling this bit? Is it only suspend related?
> >> Can you document them or better add a pointer to the documentation.
> > 
> > I will add more, in fact, it fixes the bug which flag BIT(1) and BIT(2)
> > stands for.
> > 
> >>
> >> Further I don't like the idea of adding code, or enabling a feature on
> >> certain hardware, that is broken in the first place and fixing it in a
> >> later patch. Think about squashing it into the correct patch.
> > 
> > No fixes are related with this patch, you can see there is no "-"
> > at this patch.
> 
> Yes, there isn't any broken code (thus no "-"), but you first enable a
> feature in the hardware and in a later patch (this one) make it work
> properly.
> 

Sorry? I haven't enabled related hardware feature at previous patches.
These two bits are enable bit, we just need to enable it.

-- 

Best Regards,
Peter Chen
