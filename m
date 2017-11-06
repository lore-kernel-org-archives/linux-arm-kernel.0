From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 6 Nov 2017 23:39:06 +0100
Subject: AXP803 I2C support / AXP devicetree-bindings
Message-ID: <CAFBinCAm8pA-dh3+T4Ui+DvLv5C17Zup-FN8pvi0cUa5PgwJJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

recently I discovered that there are some X-Powers AXP chips that
support both, Allwinner's own "RSB" as well as the I2C ("TWSI" in the
datasheet) busses.

one chip that supports both interfaces is the AXP803
the datasheet is linked in the public PINE64 wiki: [1] (direct link: [0])

currently the "x-powers,axp803" binding is "RSB" bus specific as it's
currently only listed in drivers/mfd/axp20x-rsb.c

was there a discussion about supporting both, the "RSB" and I2C bus
for one chip (for example the AXP803) in the past (I couldn't find
anything online)?
what about the device-tree bindings in this case?


Regards
Martin


[0] http://files.pine64.org/doc/datasheet/pine64/AXP803_Datasheet_V1.0.pdf
[1] http://wiki.pine64.org/index.php/PINE_A64_Main_Page#Datasheets_for_Components_and_Peripherals
