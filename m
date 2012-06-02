From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 2 Jun 2012 20:57:17 +0200
Subject: Kernel 3.4 on Dreamplug: no serial console
Message-ID: <20120602185717.GA19945@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans

Do you have SERIAL_OF_PLATFORM enabled. Without that, the serial ports
won't work.

   Andrew
