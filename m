From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Nov 2016 22:27:09 +0100
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Add 88E6176 device tree support
In-Reply-To: <1480280279-9552-2-git-send-email-afaerber@suse.de>
References: <1480280279-9552-1-git-send-email-afaerber@suse.de>
 <1480280279-9552-2-git-send-email-afaerber@suse.de>
Message-ID: <20161127212709.GD13318@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 09:57:59PM +0100, Andreas F?rber wrote:
> This model is found on the Turris Omnia.

This driver already supports nearly 30 different Marvell switch
models. Please document why the marvell,mv88e6176 is special and why
it needs its own compatible string when the others don't.

      Andrew
