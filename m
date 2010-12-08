From: simon@sequanux.org (Simon Guinot)
Date: Wed, 8 Dec 2010 15:53:54 +0000
Subject: Driver for Hard Disk GPIOs
Message-ID: <20101208155354.GH1377@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On some LaCie boards (and probably others), it is possible to control
hard disk power using dedicated GPIOs as 'power enable' and 'presence
detection'. I would like to add a driver for this GPIOs. The most
interesting target is to provide support for scattered disk power-up.

After a quick search, I have failed to match hard disk GPIOs with an
existing Linux driver category. Where could be the appropriate location
in the Linux tree ?

Any hints are welcome.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101208/f1a13660/attachment.sig>
