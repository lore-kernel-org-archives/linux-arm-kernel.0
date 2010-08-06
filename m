From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 06 Aug 2010 13:23:37 +0900
Subject: [PATCH 0/3] ARM: S5PC210: GPIO library support
Message-ID: <20100806042337.GA19427@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S5PC210 has three GPIO base addresses.

Part1 Base Address=0x11400000
Part2 Base Address=0x11000000
Part3 Base Address=0x03860000

Arrange the GPIO address as part number. and implement GPIO library

To handle GPIO library at S5PC210 properly. It needs to modify existing
frameworks which is only designed for One GPIO.
