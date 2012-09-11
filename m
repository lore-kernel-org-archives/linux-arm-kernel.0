From: jgarzik@pobox.com (Jeff Garzik)
Date: Tue, 11 Sep 2012 13:11:28 -0400
Subject: [PATCH 07/16] ARM: pxa: move platform_data definitions
In-Reply-To: <1347368390-31252-7-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-7-git-send-email-arnd@arndb.de>
Message-ID: <504F70C0.7070307@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 08:59 AM, Arnd Bergmann wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
>
> This moves such data out of the pxa include directories
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Daniel Ribeiro <drwyrm@gmail.com>
> Cc: Stefan Schmidt <stefan@openezx.org>
> Cc: Harald Welte <laforge@openezx.org>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Paul Parsons <lost.distance@yahoo.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Tomas Cech <sleep_walker@suse.cz>
> Cc: Sergey Lapin <slapin@ossfans.org>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Samuel Ortiz <samuel@sortiz.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Cc: openezx-devel at lists.openezx.org

Acked-by: Jeff Garzik <jgarzik@redhat.com>
