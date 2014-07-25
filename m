From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Fri, 25 Jul 2014 22:45:14 +0100
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <5237362.DJsH7MtqlU@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <5426556.OzZIXLrofJ@wuerfel>
 <1406285147.8530.13.camel@smile.fi.intel.com>
 <5237362.DJsH7MtqlU@wuerfel>
Message-ID: <20140725224514.10f13885@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The current plan I think is to convert all platforms to use DT
> or ACPI so they get the right data from tables passed by the
> platform. I'm a bit puzzled about why Intel wants to support the
> non-ACPI non-DT case again. If we have to support this case anyway,
> what good will ACPI do us on those platforms?

Because some industries move very very slowly so still don't believe in
requiring ACPI or ACPI capable operating systems.

Alan
