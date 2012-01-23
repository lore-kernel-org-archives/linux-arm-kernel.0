From: T.Mehnert@eckelmann.de (Mehnert, Torsten)
Date: Mon, 23 Jan 2012 10:14:33 +0000
Subject: i.mx serial driver expanion (DTR/DSR, DCD, rs485)
Message-ID: <3F263ABB4EDE344D974E1983B568077399FDA016@EX-DAG01.eckelmann.group>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

we are currently developing at the imx serial driver. We are planing to
implement two new functions and want to share them with others.

Now the question: Which of our code could be interesting for mainline?

1.) Set and readout DSR/DTR in DTE style, handle DCD

2.) handle direction handling in RS485 Master mode (like the amtel does,
Using TIOCSRS485 and TIOCGRS485).


have a good week start!

Regards,
Torsten

Torsten Mehnert
K?lte- und Geb?udeleittechnik (KGL)

ECKELMANN AG
Berliner Stra?e 161
D - 65205 Wiesbaden

Phone:   +49 (0) 611 / 7103 - 370
Fax:     +49 (0) 611 / 7103 - 133

e-Mail:  mailto:t.mehnert at eckelmann.de
Web:     http://www.eckelmann.de

ECKELMANN AG
Vorstand: Dr.-Ing. Gerd Eckelmann (Vorsitzender), Dr.-Ing. Peter Cordes, Dr.-Ing. Frank-Thomas Mellert
Vorsitzender des Aufsichtsrats: Hubertus G. Krossa
Sitz der Gesellschaft: Wiesbaden, Berliner Str.161
Amtsgericht Wiesbaden, HRB 12636
