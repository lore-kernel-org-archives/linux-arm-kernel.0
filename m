From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 26 Aug 2009 23:19:59 -0700
Subject: [PATCH-v2][RFC] OMAP4: Keypad Support for OMAP4430
In-Reply-To: <47940.192.168.10.88.1251196743.squirrel@dbdmail.itg.ti.com>
References: <47940.192.168.10.88.1251196743.squirrel@dbdmail.itg.ti.com>
Message-ID: <20090827065208.9B1C0526EC9@mailhub.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2009 at 04:09:03PM +0530, Syed Rafiuddin wrote:
> From: Syed Rafiuddin <rafiuddin.syed@ti.com>
> 
> Resending with correct Subject.
> 
> This patch Adds Keypad support on OMAP4.And adds
> OMAP4 register addresses and configures them for OMAP4.
> 
> 
> This patch has been updated as per the comments received from
> Trilok Soni to remove GPIO based omap2 keypad logic from omap_keypad.c
> (http://www.mail-archive.com/linux-omap at vger.kernel.org/msg14570.html)
> Matrix_keypad.c (gpio based keypad driver) can be used in OMAP2,
> which is not tested on OMAP2 since unavailability of omap2 target's.
> 

So has omap2 been switched over to matrix-keypad? Otherwise ripping
omap2 support from omap-keypad is premature.

-- 
Dmitry
