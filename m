From: brl@pcpool00.mathematik.uni-freiburg.de (Bernhard R. Link)
Date: Wed, 16 Jun 2010 09:29:55 +0200
Subject: [PATCH] orion/kirkwood: reset PCIe unit on boot
In-Reply-To: <1276029158-22159-1-git-send-email-razzor@kopf-tisch.de>
References: <1276029158-22159-1-git-send-email-razzor@kopf-tisch.de>
Message-ID: <20100616072955.GA12905@pcpool00.mathematik.uni-freiburg.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olaf Rempel <razzor@kopf-tisch.de> [100615 16:52]:
> Patch found in QNAPs vendor source package, with some cleanups
> (proper defines, shortened max. timeout from 1s to 200ms).
> 
> Without this patch the PCIe SATA controller (Marvell 88sx7042/sata_mv)
> in my QNAP TS-419P (Marvell 88f6281/Kirkwood) stops working after a
> few minutes.
> The symptomes are described in this thread:
> http://marc.info/?l=linux-ide&m=124822863706181&w=2

As far as I can tell, that patch fixes those hangs for me, too.

	Bernhard R. Link
