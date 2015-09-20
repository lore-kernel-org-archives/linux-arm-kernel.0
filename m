From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 17:02:18 -0400
Subject: [PATCH 0/1] musb: sunxi: Make sunxi musb glue work without
 MUSB_PIO_ONLY
Message-ID: <1442782939-25455-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a patch to fix the sunxi musb glue not working when MUSB_PIO_ONLY
is not set in the kernel config.

Since the sunxi musb glue was just merged for 4.3, it would be nice if
this bugfix could be added to 4.3 too, without this distro's will be
unable to enable dma with musb and have working sunxi musb support.

Thanks & Regards,

Hans
