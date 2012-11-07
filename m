From: shiraz.linux.kernel@gmail.com (Shiraz Hashim)
Date: Wed, 7 Nov 2012 11:42:04 +0530
Subject: possibility of parent clock selection through DT
Message-ID: <CAPub14-CPS48gQ1h8vvAYBpO_=egjheG_rMoZ894Y4XZ2CinUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Rob,

Devices in a SoC can have multiple possible clock sources which is
perfectly captured through clk framework.

But the device itself may not be aware of the complex hierarchy above it.
In this case how do you suggest a board (through DT) should select its
preference.

Is there some work already going on in this direction ?

-- 
regards
Shiraz Hashim
