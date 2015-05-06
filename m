From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 May 2015 16:05:34 +0200
Subject: [PATCH v3 0/1] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <ad0fbb28b4b74de4c6685a5ddd21010c@mail.ncrmnt.org>
References: <1430663256-22714-1-git-send-email-andrew@ncrmnt.org>
 <20150503205043.GA23342@lunn.ch>
 <ad0fbb28b4b74de4c6685a5ddd21010c@mail.ncrmnt.org>
Message-ID: <20150506140534.GC10890@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >Take a look at the marvell,reg-init property. Might do what you need.
> >
> >     Andrew
> 
> Thanks for the tip. So far I'm solving it via u-boot.
> You have to set RGMII voltage there anyway if you want tftp for the
> updates,
> so it looks like the right place to do this kind of stuff.

It is heard to guarantee that the bootloader does this stuff. It is
better if the kernel is more standalone.
> 
> I'll add the proper magic to the dts file and resend tomorrow.

Thanks
	Andrew
