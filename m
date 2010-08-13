From: oneukum@suse.de (Oliver Neukum)
Date: Fri, 13 Aug 2010 15:53:19 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <732137.54230.qm@web180303.mail.gq1.yahoo.com>
References: <732137.54230.qm@web180303.mail.gq1.yahoo.com>
Message-ID: <201008131553.19875.oneukum@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 13. August 2010, 15:42:32 schrieb David Brownell:
> > > 2) Require that usb_submit_urb() accept byte aligned buffers.
> 
> I believe we already require that.  Of course,
> the requirement is on HCDs, not on th

Divers fail if HCDs can't do it. But we've never explicitly said that HCDs
need to be able to do that. We should probably document that requirement.

	Regards
		Oliver
