From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 03 Jan 2018 12:18:15 +0100
Subject: [PATCH V4 22/26] video: fbdev: intelfb: deprecate
 pci_get_bus_and_slot()
In-Reply-To: <7099e2af-4704-4611-94c0-830483de4578@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <CGME20180102133833epcas1p4003614ea6c95c4568e8433acbb30f52d@epcas1p4.samsung.com>
 <7099e2af-4704-4611-94c0-830483de4578@codeaurora.org>
Message-ID: <1712261.2Mai7cXr8p@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 02, 2018 08:38:24 AM Sinan Kaya wrote:
> On 12/19/2017 12:37 AM, Sinan Kaya wrote:
> > pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> > where a PCI device is present. This restricts the device drivers to be
> > reused for other domain numbers.
> > 
> > Getting ready to remove pci_get_bus_and_slot() function in favor of
> > pci_get_domain_bus_and_slot().
> > 
> > Find the domain number from pdev.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Any feedback here ? most of the remaining patches have the ACK except these.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
