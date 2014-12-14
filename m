From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 14 Dec 2014 10:47:57 +0100
Subject: bluetooth: Add hci_h4p driver
In-Reply-To: <ED6FB9B5-7BD5-4398-ACA4-C5D1547B91A4@holtmann.org>
References: <20141213223727.GA13894@amd>
 <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
 <20141213235131.GA23566@amd>
 <ED6FB9B5-7BD5-4398-ACA4-C5D1547B91A4@holtmann.org>
Message-ID: <20141214094757.GA28973@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2014-12-14 01:07:42, Marcel Holtmann wrote:
> Hi Pavel,
> 
> >>> My notes say that Marcel wanted different filenames, but I'd need
> >>> advice exactly what filenames. I guess platform data supprort should
> >>> be removed altogether, rather than renamed.
> >> 
> >> Yes, the platform support should go away. This should be purely based on DT.
> >> 
> >> Can you also start using git format-patch so that patches get a diffstat.
> > 
> > So the rest of filenames look ok?
> 
> I have not looked at the patch or the filenames at all.

Ok, so here's diffstat. Can you take a look?

Thanks,
									Pavel

 drivers/bluetooth/Kconfig                  |   10 
 drivers/bluetooth/Makefile                 |    3 
 drivers/bluetooth/hci_h4p.h                |  234 +++++
 drivers/bluetooth/nokia_core.c             | 1262 +++++++++++++++++++++++++++++
 drivers/bluetooth/nokia_fw-bcm.c           |   27 
 drivers/bluetooth/nokia_fw.c               |  105 ++
 drivers/bluetooth/nokia_uart.c             |  179 ++++
 include/linux/platform_data/bt-nokia-h4p.h |    4 
 8 files changed, 1822 insertions(+), 2 deletions(-)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
