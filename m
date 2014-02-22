From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 22 Feb 2014 17:22:52 +0100
Subject: [RFC 0/3] ahci_platform: drop support for a bunch of obsolete
 platform device types
Message-ID: <1393086175-6383-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun, Marek,

This series, which is to be applied on top of my ahci_platform restructering
series,  mostly speaks for itself.

I've some doubts about the 2nd patch, which removes the imx53-ahci platform
device support from ahci_platform.c. I'm pretty sure this is obsolete and
replaced by Marek's ahci_imx.c work, but not 100%, which is why this series
is marked as RFC. Marek can you confirm that the code the 2nd patch removes
is inded dead code?

Tejun, if Marek confirms this is indeed dead code feel free to apply this
despite the RFC marking.

Thanks & Regards,

Hans
