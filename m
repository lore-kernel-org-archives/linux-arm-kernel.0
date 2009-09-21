From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 22:40:31 +0100
Subject: [PATCH V2 0/3] at91_can: add support for Atmel's CAN
	controller on AT91SAM9263
In-Reply-To: <cd73a99e0909211431k37429a70o4efaac7104f7d526@mail.gmail.com>
References: <1253180254-11910-1-git-send-email-mkl@pengutronix.de>
	<4AB20679.2040602@grandegger.com> <4AB209CB.10707@pengutronix.de>
	<cd73a99e0909211431k37429a70o4efaac7104f7d526@mail.gmail.com>
Message-ID: <20090921214031.GI30821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 11:31:19PM +0200, Andrew Victor wrote:
> hi Marc,
> 
> >>> Marc Kleine-Budde (3):
> >>> ? ? ? at91sam9263: add at91_can device to generic device definition
> >>> ? ? ? at91sam9263ek: activate at91 CAN controller
> >>> ? ? ? at91_can: add driver for Atmel's CAN controller on AT91SAM9263
> >>
> >> I have just added my "signed-off-by" for the Socket-CAN patch #3. Don't
> >> known who will take care of the other patches.
> >
> > Thanks Wolfgang.
> >
> > Andrew, are the first two going throught the arm tree?
> 
> That would be best.
> Please submit them to Russell King's patch system.

While we're at at91 stuff, please can someone see about fixing the
AC97 breakage with at91cap9adk_defconfig please, or confirming that
patches I already have fix this?
