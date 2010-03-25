From: hjk@linutronix.de (Hans J. Koch)
Date: Thu, 25 Mar 2010 21:04:27 +0100
Subject: [PATCH 0/7 v2] Add basic support for Telechips TCC8xxx SoCs
Message-ID: <20100325200427.GC2047@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of my patch series to introduce basic support for Telechips
TCC8xxx SoCs. It addresses the issues found after v1. They're all in
[PATCH 5/7] (mapping of DTCM and SDRAM). I threw out both mappings.
They've got no users right now, and the datasheet is not very clear
about the DTCM. I need to get more information from Telechips and run
my own tests.

Please review.

Thanks,
Hans
