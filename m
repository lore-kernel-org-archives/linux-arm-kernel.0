From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 25 Nov 2013 20:42:56 +0100
Subject: ARM: nommu: Boot hang after VFS: Mounted root (ext2 filesystem)
 on device 1:0.
In-Reply-To: <1385393160.4753.4.camel@phoenix>
References: <1385393160.4753.4.camel@phoenix>
Message-ID: <20131125194256.GC28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 25, 2013 at 11:26:00PM +0800, Axel Lin wrote:
> I got hangup at boot after "VFS: Mounted root (ext2 filesystem) on device 1:0.".
> I'm using ext2 initrd as root.
which mainline version are you using? I don't know your problem, and I'm
not using ext2 on my nommu target. So the only thing I can offer you is
testing the same version.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
