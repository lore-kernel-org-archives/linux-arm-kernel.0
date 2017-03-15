From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 15 Mar 2017 19:52:14 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
Message-ID: <20170315185214.GF21021@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek

> - It has two switches in order to support 8 lan ports. Internal switch is
>   BCM53012. The external switch BCM53125 currently works as "dumb switch"

Do you know how the second switch is connected? Is it cascaded off the
internal switch? Or does it have a dedicated Ethernet interface?

Thanks
	Andrew
