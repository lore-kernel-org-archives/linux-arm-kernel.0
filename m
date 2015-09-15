From: yassinjaffer@gmail.com (yassinjaffer at gmail.com)
Date: Wed, 16 Sep 2015 00:05:53 +1000
Subject: NEW SUN4i KEYPAD DRIVER 
Message-ID: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the sun4i keypad Controller
I've tested the driver in a A20 custom board (4x4) only
Allwinner keypad controller does not seem to handle more
than two key press

Please test and report bugs. Thank you in advance

[PATCH 1/4] ARM:dts:sun7i: Add keypad clk node
[PATCH 2/4] ARM: dts: sun7i: Add keypad node to Allwinner A20 SoC
[PATCH 3/4] input: Add new sun4i-keypad driver
[PATCH 4/4] devicetree: bindings:Allwinner sun4i keypad
