From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 11 Jan 2018 20:29:12 +0000
Subject: [RFC PATCH 0/2] drivers: clk: Add ZynqMP clock driver support
In-Reply-To: <6004ad81-96f1-34d9-a037-2c355720dc08@arm.com>
References: <1515449797-5629-1-git-send-email-jollys@xilinx.com>
 <6004ad81-96f1-34d9-a037-2c355720dc08@arm.com>
Message-ID: <DM2PR0201MB0767E1E08918BED4CB06DB20B8160@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

There are 3 things:

1> IPI mailbox transport - series is already posted
https://patchwork.kernel.org/patch/10145795/
2> EEMI - Posted by me below
https://patchwork.kernel.org/patch/10150665/
3> EEMI Users
Currently posted as RFC as they are dependent on #2.

#2 doesn?t use mailbox so it is a posted as a separate series. 

Thanks,
Jolly Shah



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Thursday, January 11, 2018 2:55 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; michal.simek at xilinx.com; linux-
> clk at vger.kernel.org
> Cc: mturquette at baylibre.com; sboyd at codeaurora.org; Sudeep Holla
> <sudeep.holla@arm.com>; Jolly Shah <JOLLYS@xilinx.com>; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC PATCH 0/2] drivers: clk: Add ZynqMP clock driver support
> 
> 
> 
> On 08/01/18 22:16, Jolly Shah wrote:
> > Add clock driver for ZynqMP
> >
> 
> Can you post the complete series in one set for easy of review. It's currently
> broken into *6 - 8* different sets by different authors and it's extremely hard to
> get the full view of how these pieces are connected and extremely misleading.
> Can someone post them collectively as you would already have it if you are
> doing some testing building on each patch set.
> 
> IIUC mailbox is used for all the communication, right ?
> If so, to start with just have 2 series one for mailbox/transport and another for
> the whole protocol(eemi?) and users of it.
> 
> --
> Regards,
> Sudeep
