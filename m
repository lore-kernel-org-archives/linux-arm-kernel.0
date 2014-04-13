From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 13 Apr 2014 18:59:34 +0200
Subject: [PATCH 26/29] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <20140413185304.358c1c42@skate>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-27-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413154715.GE10033@lunn.ch> <20140413175658.64b65a76@skate>
 <20140413155949.GG10033@lunn.ch> <20140413185304.358c1c42@skate>
Message-ID: <534AC276.70009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 06:53 PM, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Sun, 13 Apr 2014 17:59:49 +0200, Andrew Lunn wrote:
> 
>> I hope kirkwood will complete its move soon. I have Openrd in a state
>> it can move to mvebu, So that only leaves netxbig_v2.c.
> 
> Nice, that would be a good move. Regarding netxbig_v2.c, looks like I
> need to revive
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/188443.html.
> 
> On the mach-dove front, what is preventing the removal of the old style
> cm-a510.c and dove-db-setup.c, since I see there are Device Tree for
> those platforms? Maybe they are not complete? Maybe the biggest problem
> is testing PCIe?

cm-a510 and dove-db have never seen any love since we moved to DT. The
board files basically only add serial devices nothing more. Nobody
complained about it and I guess we'll just drop support for them.

Consider mach-dove deprecated and dying.

Sebastian
