From: roman.tereshonkov@nokia.com (Roman)
Date: Wed, 23 Dec 2009 12:19:02 +0200
Subject: Amba device porting
Message-ID: <20091223101902.GA15537@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I planned to port the omap3 SDTI (Serial Debug Trace Interface) driver to amba based interface.

SDTI memory map is two parts composed:
0x54500000 0x5450FFFF 4KB       SDTI module (configuration) - coresight based format.
0x54510000 0x545FFFFF 1984KB    Reserved
0x54600000 0x546FFFFF 1MB       SDTI module (window)

But amba interface seems to support only one memory region resource.

Is there any way to pass two memory regions?


Regards
Roman Tereshonkov
