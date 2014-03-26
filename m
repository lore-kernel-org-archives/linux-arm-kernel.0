From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 26 Mar 2014 17:36:03 +0000
Subject: [PATCH] ata: fix Marvell SATA driver dependencies
In-Reply-To: <4852939.9jMb8Bv2x2@amdc1032>
References: <5138028.BSQbEP7RRB@amdc1032> <20140326162302.GG25349@lunn.ch>
 <20140326165904.70de238d@alan.etchedpixels.co.uk>
 <4852939.9jMb8Bv2x2@amdc1032>
Message-ID: <20140326173603.50e50e34@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> shows up it is not enough to enable driver for it to make it work as
> you also need to add a node describing your SATA MV variant to your SoC
> device tree file (which requires updating kernel source anyway).

You still have to recompile your kernel to update your device tree..
how... quaint ;-). It's not a generic limitation but I'm not that fussed.
It seems a fair argument that there would be other changes made when this
was being done for a system, and probably new board stuff.

Alan
