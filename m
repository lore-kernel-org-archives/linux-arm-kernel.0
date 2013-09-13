From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Fri, 13 Sep 2013 23:31:58 +1200
Subject: [RFC PATCH 0/3] Enable BCM2835 mailbox support
Message-ID: <5232F7AE.1020603@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is an implementation of BCM2835 mailbox support built on 
top of the framework implemented by by Suman Ana and Jassi Brar.  It is 
also meant to be a validation of the framework against another platform.

In order to be an effective test, the patch set also includes a mailbox 
client - a driver for the built-in CPU thermal sensor, which gets 
readings via a mailbox request and reply.

Both the mailbox driver [PATCH 2/3] and the thermal driver [PATCH 3/3] 
should be complete.  However, [PATCH 1/3] is not a formal part of this 
submission. It is only included to simplify testing of patches 2 and 3. 
This is why this patch set is only RFC; it cannot really proceed further 
until without the generic mailbox support.

Cheers,
Craig.
