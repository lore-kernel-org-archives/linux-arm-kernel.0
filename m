From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Jul 2014 09:51:05 +0200
Subject: [PATCH v2 00/14] AT91: PIT: Cleanups and move to
 drivers/clocksource
In-Reply-To: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140710075105.GA27469@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Jul 01, 2014 at 11:33:13AM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> This series cleans up the PIT driver in order for it to not depend on
> anything in mach-at91 anymore, and in the end move it out of
> mach-at91.
> 
> Along the way, these patches also do a bit of cleanup.
> 
> This has been tested on a G45-EK without DT and an Xplained with DT.
> 

Even though most of this patches are not clocksource related, it would
be great if we could at least get an acked-by on the last patch that
moves the driver to drivers/clocksource, since it pretty much becomes
your burden :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/1a18c9ef/attachment.sig>
