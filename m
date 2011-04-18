From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 18 Apr 2011 07:33:10 +0200
Subject: [PATCH v3] at91: remove MTD_NAND_ATMEL_BUSWIDTH_16 option
In-Reply-To: <BANLkTimmvDZRzFX4Z6m7Y2jEZx9a89uwVQ@mail.gmail.com>
References: <1302784833-25930-1-git-send-email-plagnioj@jcrosoft.com>
	<1302795935-11175-1-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTimmvDZRzFX4Z6m7Y2jEZx9a89uwVQ@mail.gmail.com>
Message-ID: <20110418053310.GA4267@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:39 Sun 17 Apr     , Andrew Victor wrote:
> hi,
> 
> > no board configure it as 'n' and it's an issue to merge all defconfigs
> > in one
> >
> > On AT91SAM926x boards both types of NAND flash can be present
> > (8 and 16 bit data bus width).
> >
> > so will pass it via system_rev
> 
> If nobody is using the configuration option and therefore 8-bit flash,
> why not just remove the whole configuration option?
> If there is some non-merged board with 8-bit flash, then they should
> have their own board-file anyway and can just set
> "ek_nand_data.bus_width_16" as required.
> 
> Lets not add complex run-time configuration where it's not needed.
Except the board can have a 16bit or 8bit nand flash on the pcb

So people can change it.

Best Regards,
J.
