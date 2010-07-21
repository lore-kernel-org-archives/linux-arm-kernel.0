From: bjoern.slotkowski@imc-berlin.de (Bjoern Slotkowski)
Date: Wed, 21 Jul 2010 11:59:27 +0200
Subject: Random crash using fork in a multithreaded application
Message-ID: <FPEIIEKCABPOOBGGCOCHKEPCCGAA.bjoern.slotkowski@imc-berlin.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

we have a problem using fork in a multitheaded application.
Our application crashes somewhere with a segfault.
This happens randomly ( within 2 hours to 2 days)
The fork is done every 10 s.

The crash happens after do_fork and before execve.
One thread which is not involved in the forking gets the segfault.

This happens on an arm at91rm9200.

Our kernelversion is 2.6.14, I know it is old,
but we don't have a chance to update the kernel.


When looking through the mailininglists
I found a mail describing the same issue
but no real reason for this behaviour.

When comparing Kernel 2.6.14 and 2.6.15.4 I saw some differences,
but in the Changelog it appeared as if these differences do not fix an
error.

Can someone point me into the right direction.
(Where to get more information, is this a known and hopefully solved issue).

Thanks a lot in advance,

Bjoern Slotkowski

--
imc Messsysteme GmbH
Bereich Entwicklung / Dept. Development
Voltastra?e 5
D-13355 Berlin
Germany
Tel:   +49 30 46 70 90 23
Fax:   +49 30 46 31 57 6
mailto:Bjoern.Slotkowski at imc-berlin.de
Homepage: http://www.imc-berlin.de

Sitz der Gesellschaft : Berlin
Handelsregister       : Berlin-Charlottenburg HRB 28778
Gesch?ftsf?hrer       : Dr.-Ing. Dietmar Sprenger
