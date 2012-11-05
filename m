From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 5 Nov 2012 19:28:29 +0100
Subject: [PATCH v3 0/6] DT support for AT91RM9200
In-Reply-To: <CAGhQ9Vxek1Xju4ShRV0KZtE4gsg-KZjG=6n+B54ddEv-6v9yXA@mail.gmail.com>
References: <1351449071-5763-1-git-send-email-manabian@gmail.com>
 <20121104155212.GK19021@game.jcrosoft.org>
 <CAGhQ9VzWxhM7QitutizN3WB6w-bDTDia9Bo6xNQ_F0runJMiqQ@mail.gmail.com>
 <20121105072857.GL19021@game.jcrosoft.org>
 <CAGhQ9Vxek1Xju4ShRV0KZtE4gsg-KZjG=6n+B54ddEv-6v9yXA@mail.gmail.com>
Message-ID: <20121105182829.GB20063@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:59 Mon 05 Nov     , Joachim Eastwood wrote:
> On 5 November 2012 08:28, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 18:55 Sun 04 Nov     , Joachim Eastwood wrote:
> >> On 4 November 2012 16:52, Jean-Christophe PLAGNIOL-VILLARD
> >> <plagnioj@jcrosoft.com> wrote:
> >> > On 19:31 Sun 28 Oct     , Joachim Eastwood wrote:
> >> >> Patch 1 is a fix for a build failure which can happen if board-dt is enabled when no AT91SAM machines are enabled.
> >> >>
> >> >> Patch 2 adds DT support to the AT91RM9200 system timer. Based on AT91 PIT patch by Jean-Christophe PLAGNIOL-VILLARD.
> >> >>
> >> >> Patch 3 adds clock lookups for DT.
> >> >>
> >> >> Patch 4 adds a new board for RM9200 DT support.
> >> >>
> >> >> Patch 5-6 adds the base devicetree for AT91RM9200 and support for AT91RM9200-EK board.
> >> >>
> >> >>
> >> >> I don't have a AT91RM9200-EK to test on but I was able to boot at91rm9200ek.dts on my custom board using a >>initrd. As far as I can tell pinctrl, usart and ohci all work.
> >> >
> >> > After updating barebox to have the DT support I've tested it on rm9200ek with net support
> >> >
> >> > work fine
> >>
> >> Excellent.
> >>
> >> > It does not apply on my tree as I've a more patch but I'll manage the merge
> >> > conflict
> >>
> >>  Thanks for fixing it up Jean-Christophe.
> > I'll also fix the usb device and add missing nor flash support and emac +
> > pinctrl + defconfig
> 
> Very nice.
> 
> Please make the changes available via a git tree when it's ready.
for at91 the official git is on github

I've to send some patch series

I'll put them in our next

Best Regards,
J.
