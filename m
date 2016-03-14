From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 14 Mar 2016 20:01:39 +0800
Subject: NVMEM usage question
Message-ID: <1457956899.20370.25.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Mediatek PMIC chip have some spare registers used to store information.
The value of these registers will exist until user unplug battery or
battery depletion. One of our usage example is store battery utilization
in these spare registers. We want to implement NVMEM driver to
read/write sparse registers, but binding document describe NVMEM is for
"Non-volatile memory", and for hardware like eeprom, efuse. Since the
usage here is some kind of "battery backup memory", but not real
non-volatile memory, is NVMEM driver suitable for this case ?

Eddie
