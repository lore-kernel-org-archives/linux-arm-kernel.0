From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jan 2012 23:30:42 +0100
Subject: i.mx serial driver expanion (DTR/DSR, DCD, rs485)
In-Reply-To: <3F263ABB4EDE344D974E1983B568077399FDA016@EX-DAG01.eckelmann.group>
References: <3F263ABB4EDE344D974E1983B568077399FDA016@EX-DAG01.eckelmann.group>
Message-ID: <20120125223042.GE5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 10:14:33AM +0000, Mehnert, Torsten wrote:
> Hi Sascha,
> 
> we are currently developing at the imx serial driver. We are planing to
> implement two new functions and want to share them with others.
> 
> Now the question: Which of our code could be interesting for mainline?
> 
> 1.) Set and readout DSR/DTR in DTE style, handle DCD
> 
> 2.) handle direction handling in RS485 Master mode (like the amtel does,
> Using TIOCSRS485 and TIOCGRS485).

Both seem interesting. Feel free to post it to the relevant lists. Even
if the the patches do not make it to mainline it's still good for other
people when they can find it in the archives.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
