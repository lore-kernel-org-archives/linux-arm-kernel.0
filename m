From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 9 Nov 2014 16:55:02 +0100
Subject: Network timing (?) problems since kernel 3.12
In-Reply-To: <545F852D.5040209@drkrebs.de>
References: <545F852D.5040209@drkrebs.de>
Message-ID: <20141109155502.GA10013@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 04:15:57PM +0100, Markus Krebs wrote:
> Hello,
> 
> I'm using a Sheevaplug (Marvell Kirkwood) with an USB-Stick for
> storage as a server. Since kernel 3.12 I'm experiencing various
> erratic problems when transferring files, especially large or many
> files at the same time, over the network (ssh complaining about
> "Corrupted MAC on input" or Windows [over Samba] about corrupt
> files).
> Turning "offload check summing" off with ethtool didn't really help.

Try turning off gso.

    Andrew
