From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 14 Apr 2014 20:44:32 +0200
Subject: [PATCH 23/29] ARM: orion5x: use DT to describe NOR on edmini_v2
In-Reply-To: <20140413174513.2e39a55c@skate>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-24-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413153150.GD10033@lunn.ch> <20140413174513.2e39a55c@skate>
Message-ID: <20140414184432.GI22546@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi Thomas
> > 
> > Did you check if this is still true? If it is fixed, maybe now would
> > be a good time to swap to three partitions?
> 
> I don't know, and since the NOR contains the bootloader, and I'm not
> sure those Orion devices support UART booting

Hi Thomas

I had a quick look at the datasheet. I could not find any mention of
booting from Serial. So i agree, without having a tested JTAG setup,
play safe and leave the partitions alone.

	Andrew
