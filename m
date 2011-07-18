From: ratheendran.s@gmail.com (Ravi)
Date: Mon, 18 Jul 2011 09:44:13 +0000 (UTC)
Subject: seria port communication on linux with rts signal
Message-ID: <loom.20110718T113615-870@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

I want to interface a printer on RS232 port of my arm board.the printer has
RX,TX and CTS signals from printer. This pin will turn to logic low indicating
printer is ready to receive data. If Printer is not ready to print then the
signal will
change to Logic High. I have interfaced null modem communication on serial
port.can any one let me know the changes to accommodate CTS signal interrupt
from printer.

Thanks & Regards,
Ratheendran
