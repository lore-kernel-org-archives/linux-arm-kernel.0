From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 23 Dec 2012 09:48:57 -0200
Subject: [PATCH 4/4] efikamx: remove Efika MX-specific CHRGVBUS hack from
 the USB driver
In-Reply-To: <CAKGA1bnzYWG5POJ228ytayXztoXcMXt2rB-4S6fnrv5Gxo_=TQ@mail.gmail.com>
References: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
 <1343843371-14143-5-git-send-email-matt@genesi-usa.com>
 <CAOMZO5CcUZ8NKM6uHkBB1Yo9MjeoBq9NzpOYwT1squM4TOgV7g@mail.gmail.com>
 <CAKGA1bnzYWG5POJ228ytayXztoXcMXt2rB-4S6fnrv5Gxo_=TQ@mail.gmail.com>
Message-ID: <CAOMZO5DDV5HVF+WNd8gUmwpfmxiFQcjWBWkNfNT1cdpHLCoVGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 23, 2012 at 8:42 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> Anyone got a clue who the actual USB maintainer is who cares about ehci-mxc?

$ ./scripts/get_maintainer.pl -F drivers/usb/host/ehci-mxc.c
Alan Stern <stern@rowland.harvard.edu> (maintainer:USB EHCI DRIVER)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
linux-usb at vger.kernel.org (open list:USB EHCI DRIVER)
linux-kernel at vger.kernel.org (open list)

> Best search through the maintainers file is Li Yang <leoli@freescale.com>
> and of course I could always nudge David Brownell, Sascha (your name is at
> the top of the file!)
>
> I was going to resubmit on Friday and push an alternative patch to the
> chipidea driver but I can't figure out who's in control, if the only nitpick
> is I didn't CC the right people then this could take many, many submissions
> while this gets figured out :D

$ ./scripts/get_maintainer.pl -F drivers/usb/chipidea/host.c
Alexander Shishkin <alexander.shishkin@linux.intel.com>
(maintainer:CHIPIDEA USB HIGH...)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
linux-usb at vger.kernel.org (open list:CHIPIDEA USB HIGH...)
linux-kernel at vger.kernel.org (open list)

Regards,

Fabio Estevam
