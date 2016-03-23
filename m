From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 23 Mar 2016 09:39:19 -0400
Subject: [PATCH v4] tty: serial: meson: Implement earlycon support
In-Reply-To: <56F27268.4060902@suse.de>
References: <1457263284-8819-1-git-send-email-afaerber@suse.de>
 <56F27268.4060902@suse.de>
Message-ID: <20160323133919.GA4235@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 11:39:36AM +0100, Andreas F?rber wrote:
> Am 06.03.2016 um 12:21 schrieb Andreas F?rber:
> > Split off the bulk of the existing meson_serial_console_write()
> > implementation into meson_serial_port_write() for implementing
> > meson_serial_early_console_write().
> > 
> > Use "meson" as the earlycon driver name, courtesy of Nicolas.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
> > Acked-by: Carlo Caione <carlo@endlessm.com>
> > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > ---
> >  v3 -> v4:
> >  * Select SERIAL_EARLYCON (Arnd)
> 
> Ping?

It's the middle of the merge window, there's nothing I can do at the
moment, please wait for after 4.6-rc1 is out before I can start catching
up...

greg k-h
