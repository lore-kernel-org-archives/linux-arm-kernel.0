From: zonque@gmail.com (Daniel Mack)
Date: Tue, 12 Jul 2011 11:57:53 +0200
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <CALZhoSRPYtMtsDqY5rPKfx4ux72iCDPQm=3wmTMMt2_P3zWtKA@mail.gmail.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
	<1309771536-10597-4-git-send-email-leiwen@marvell.com>
	<4E1411BB.4010000@compulab.co.il>
	<CACTFLAOmRMDH_6qo_WkndoWX-HPw9RTqbtsURDfw22sWEFS2wg@mail.gmail.com>
	<4E1B3ECC.5080308@compulab.co.il>
	<CACTFLAPMh+XMpOPPqkDTaEZppSkWxVxFMH3RALTmqOCNk8WAvw@mail.gmail.com>
	<4E1B4E21.1090507@compulab.co.il>
	<CALZhoSRPYtMtsDqY5rPKfx4ux72iCDPQm=3wmTMMt2_P3zWtKA@mail.gmail.com>
Message-ID: <CACTFLAOe_iL8W_+dAPrJEA=_npN9gmH38Xhz__nvy73BYCYBHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 11:40 AM, Lei Wen <adrian.wenl@gmail.com> wrote:
> I retest with suspend&resume on my board, each time that board would
> reset the timing in the
> begining of pxa3xx_cmdfunc as expected. So this should be ok as it is
> the same behavior
> with original code.

Ok, just to be sure - as there have been quite some iterations fot
this now - can you send me a link to your most current version of this
patch again, please? Just to avoid confusion which version we're
talking about.


Thanks,
Daniel
