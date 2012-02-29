From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Feb 2012 09:42:21 +0100
Subject: [PATCH v2 2/2] ARM: mx3: Let mx31 and mx35 enter in LPM mode in
 WFI
In-Reply-To: <CAOMZO5C=iMp-Wqf9tDKhTV7bKBezxkp2RbHKpjRCL0v1tx8bdQ@mail.gmail.com>
References: <1328220152-3037-1-git-send-email-festevam@gmail.com>
 <1328220152-3037-2-git-send-email-festevam@gmail.com>
 <CAOMZO5C=iMp-Wqf9tDKhTV7bKBezxkp2RbHKpjRCL0v1tx8bdQ@mail.gmail.com>
Message-ID: <20120229084221.GV3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 09:47:45AM -0300, Fabio Estevam wrote:
> Hi Sascha,
> 
> On 2/2/12, Fabio Estevam <festevam@gmail.com> wrote:
> > The LPM field of register CCMR is used to select the mode that the processor
> > will run
> > when it goes to WFI.
> >
> > When mx31 enters in WFI mode the LPM field is at its reset value of 0,
> > which configures the mx31 to enter in "wait mode".
> >
> > On mx35, the LPM field on mx35 is also at 0 after reset, which corresponds
> > to "run mode" instead of "wait mode".
> >
> > Instead of relying on the reset value of LPM to set the low power mode for
> > WFI, configure mx31 and mx35 to run in "wait mode"
> >
> > Reported-by: Benoit Thebaudeau <benoit.thebaudeau@advansee.com>
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> I saw that you applied 1/2, but not 2/2.
> 
> Is there anything I should rework in this patch?

Nope, I just lost it. I'll queue it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
