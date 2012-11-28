From: m-watanabe@plathome.co.jp (Mio Watanabe)
Date: Wed, 28 Nov 2012 11:45:01 +0900
Subject: [PATCH] arm: mvebu: support for the PlatHome OpenBlocks AX3 board
In-Reply-To: <20121127130035.GI15800@titan.lakedaemon.net>
References: <20121126102535.6a5da505@skate>
 <20121127130035.GI15800@titan.lakedaemon.net>
Message-ID: <20121128114501.6D13.F504C49B@plathome.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason and all,

Thank you for adding us to the email list.

Thomas is correct. The differences between AX3-2 and AX3-4 are only 3 as following.


                                                    AX3-2                   AX3-4  
No. of ethernet interface                2                           4
SO-DIMM slot                                none                       1                            
mini PCIe slot                                none                       1



I delite Mr. Matumoto from the list since he quit Plat'Home already and
I am his successor. Please just remain "eg@". It is a mailing list
including our development section. Thank you.

Kind regards,
Mio Watanabe

????????????????????????
Plat'Home Co., Ltd.
Product Marketing Dept.
Nihon Building Kudanbekkan 3F
4-1-3 Kudankita, Chiyoda-ku, Tokyo
102-0073 Japan
TEL: ++81 (0) 3 5213 4373
FAX: ++81 (0) 3 3221-0882
E-mail : m-watanabe at plathome.co.jp



On Tue, 27 Nov 2012 08:00:35 -0500
Jason Cooper <jason@lakedaemon.net> wrote:

> On Mon, Nov 26, 2012 at 10:25:35AM +0100, Thomas Petazzoni wrote:
> > On Mon, 26 Nov 2012 10:18:47 +0100, Hector Oron wrote:
> > 
> > > I got an ax3/2 device, I would not mind to test any changes? Are you
> > > aware of which changes should I apply to dtsi file to work on ax3-2
> > > device?
> > 
> > If I'm correct, the differences between AX-2 and AX3-4 is:
> > 
> >  * AX3-2 has two Ethernet interfaces, while AX3-4 has four Ethernet
> >    interfaces
> > 
> >  * AX3-4 is in standard mounted with a 2 GB additional DRAM in a
> >    SO-DIMM slot, while the AX3-2 is not. However, it is not clear if
> >    the SO-DIMM slot is present or not on the AX3-2 (could you confirm
> >    this?).
> > 
> >  * AX3-2 does not have a mini PCIe slot, while AX3-4 has one.
> > 
> > So I guess you could create a separate armada-xp-openblocks-ax3-2.dts
> > file to support this new board. Maybe at some point it will make sense
> > to have a common armada-xp-openblocks-ax3.dtsi that both board .dts
> > includes.
> 
> Adding plathome to the email list to see if they can offer any
> concrete answers.
> 
> thx,
> 
> Jason.
